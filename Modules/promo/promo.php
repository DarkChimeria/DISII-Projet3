<?php
/**
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2017 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once(_PS_MODULE_DIR_.'promo/controllers/back/Ps_Promo.php');

class Promo extends Module
{
    protected $config_form = false;

    public function __construct()
    {
        $this->name = 'promo';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'Anthony';
        $this->need_instance = 1;

        /**
         * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
         */
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Module de Promo');
        $this->description = $this->l('Test du module de promo');

        $this->confirmUninstall = $this->l('Êtes-vous sûr de vouloir désinstaller ce module ?');

        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);
    }

    /**
     * Don't forget to create update methods if needed:
     * http://doc.prestashop.com/display/PS16/Enabling+the+Auto-Update
     */
    public function install()
    {
        //Configuration::updateValue('PROMO_LIVE_MODE', false);

        include(dirname(__FILE__).'/sql/install.php');

        return parent::install() &&
        $this->registerHook('header') &&
        $this->registerHook('backOfficeHeader') &&
        $this->registerHook('displayHome');
    }

    public function uninstall()
    {
        Configuration::deleteByName('PROMO_LIVE_MODE');

        include(dirname(__FILE__).'/sql/uninstall.php');

        return parent::uninstall();
    }


    public function getWidgetVariables()
    {
        $variables = [];
        $variables['title'] = Tools::getValue('title', '');
        $variables['description'] = Tools::getValue('description', '');
        $variables['legend'] = Tools::getValue('legend', '');
        $variables['url'] = Tools::getValue('url', '');
        $variables['image'] = Tools::getValue('image', '');
        $variables['debut'] = Tools::getValue('debut', '');
        $variables['fin'] = Tools::getValue('fin', '');
        $variables['msg'] = '';

        if (Tools::isSubmit('submitNewsletter')) {

            $variables['type_image'] = Tools::strtolower(Tools::substr(strrchr($_FILES['image']['name'], '.'), 1));
            $variables['name_image'] = $_FILES['image']['name'];
            $target_dir = dirname(__FILE__).'/images/';
            $target_file = $target_dir . basename($_FILES["image"]["name"]);


            $check = getimagesize($_FILES["image"]["tmp_name"]);
            if($check !== false) {
                echo "File is an image - " . $check["mime"] . ".";
                if (move_uploaded_file($_FILES["image"]["tmp_name"], $target_file)) {
                    echo "The file ". basename($_FILES["image"]["name"]). " has been uploaded.";
                    $sql = $this->add($variables['title'], $variables['description'], $variables['legend'], $variables['url'], $variables['name_image'], $variables['debut'], $variables['fin']); 
                    $variables['msg'] = 2;
                } else {
                    $variables['msg'] = 1;
                }

            } else {
                echo "File is not an image.";
                $variables['msg'] = 1;
            }
         }

        return $variables;
    }


    /**
     * Load the configuration form
     */
    public function getContent()
    {
        /**
         * If values have been submitted in the form, process.
         */
        if (((bool)Tools::isSubmit('submitPromoModule')) == true) {
            $this->postProcess();
        }

        $promo = $this->getSlides();

        $variables = $this->getWidgetVariables();

        $this->context->smarty->assign('title','');
        $this->context->smarty->assign('description','');
        $this->context->smarty->assign('legend','');
        $this->context->smarty->assign('url','');
        $this->context->smarty->assign('image','');
        $this->context->smarty->assign('debut','');
        $this->context->smarty->assign('fin','');
        $this->context->smarty->assign('msg',$variables['msg']);
        $this->context->smarty->assign('variables',$variables);
        $this->context->smarty->assign('slides',$promo);
        $this->context->smarty->assign('module_dir', $this->_path);

        $this->context->smarty->assign('jsdata', '<script src="../modules/promo/views/js/jquery.dataTables.min.js" type="text/javascript"></script>');

        $this->context->smarty->assign('cssdata', '<link rel="stylesheet" type="text/css" href="../modules/promo/views/css/jquery.dataTables.css">');
        $output = $this->context->smarty->fetch($this->local_path.'views/templates/admin/configure.tpl');

        return $output.$this->renderForm();
    }


    public function add($a,$b,$c,$d,$e,$f,$g)
    {
        $res = '';
        $res &= Db::getInstance()->execute("
            INSERT INTO `"._DB_PREFIX_."promo_img` (`title`, `description`, `legend`, `url`, `image`,`debut`,`fin`)
            VALUES('".$a."', '".$b."', '".$c."', '".$d."', '".$e."', '".$f."', '".$g."')"
            );

    }


    /**
     * Create the form that will be displayed in the configuration of your module.
     */
    protected function renderForm()
    {
        $helper = new HelperForm();

        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = $this->context->language->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG', 0);

        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitPromoModule';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
        .'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');

        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFormValues(), /* Add values for your inputs */
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
            );

        // Ligne de code pour afficher le formulaire de base du module
        // return $helper->generateForm(array($this->getConfigForm()));
        return $helper->generateForm(array());
    }

    /**
     * Create the structure of your form.
     */
    protected function getConfigForm()
    {
        return array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('Settings'),
                    'icon' => 'icon-cogs',
                    ),
                'input' => array(


                    array(
                        'col' => 3,
                        'type' => 'text',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('Enter an image'),
                        'name' => 'title',
                        'label' => $this->l('Titre'),
                        ),
                    array(
                        'col' => 3,
                        'type' => 'text',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('Enter an image'),
                        'name' => 'description',
                        'label' => $this->l('Description'),
                        ),
                    array(
                        'col' => 3,
                        'type' => 'text',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('Enter an image'),
                        'name' => 'legend',
                        'label' => $this->l('Légende'),
                        ),
                    array(
                        'col' => 3,
                        'type' => 'text',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('Enter an image'),
                        'name' => 'url',
                        'label' => $this->l('Url'),
                        ),                    
                    array(
                        'col' => 6,
                        'type' => 'file',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('Enter an image'),
                        'name' => 'image',
                        'label' => $this->l('Image_up'),
                        ),
                    array(
                        'col' => 4,
                        'type' => 'date',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('Enter a start date'),
                        'name' => 'debut',
                        'label' => $this->l('Debut'),
                        ),
                    array(
                        'col' => 4,
                        'type' => 'date',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('Enter a end date'),
                        'name' => 'fin',
                        'label' => $this->l('Fin'),
                        ),
                    ),
                'submit' => array(
                    'title' => $this->l('Save'),
                    ),
                ),
            );
    }

    /**
     * Set values for the inputs.
     */
    protected function getConfigFormValues()
    {
        return array(
            'PROMO_LIVE_MODE' => Configuration::get('PROMO_LIVE_MODE', true),
            'PROMO_ACCOUNT_EMAIL' => Configuration::get('PROMO_ACCOUNT_EMAIL', 'contact@prestashop.com'),
            'PROMO_ACCOUNT_PASSWORD' => Configuration::get('PROMO_ACCOUNT_PASSWORD', null),
            'PROMO_IMAGE' => Configuration::get('PROMO_IMAGE', null),
            'PROMO_IMAGE_DATE_DEBUT' => Configuration::get('PROMO_IMAGE_DATE_DEBUT', null),
            'PROMO_IMAGE_DATE_FIN' => Configuration::get('PROMO_IMAGE_DATE_FIN', null),
            );
    }

    /**
     * Save form data.
     */
    protected function postProcess()
    {
        $form_values = $this->getConfigFormValues();

        foreach (array_keys($form_values) as $key) {
            Configuration::updateValue($key, Tools::getValue($key));
        }
    }

    /**
    * Add the CSS & JavaScript files you want to be loaded in the BO.
    */
    public function hookBackOfficeHeader()
    {
        if (Tools::getValue('module_name') == $this->name) {
            $this->context->addJS($this->_path.'views/js/back.js');
            $this->context->addCSS($this->_path.'views/css/back.css');
            $this->context->addJS($this->_path.'views/fonts/back.js');
            $this->context->controller->addCSS($this->_path.'views/css/jquery.dataTables.css');
        }
    }

    /**
     * Add the CSS & JavaScript files you want to be added on the FO.
     */
    public function hookHeader()
    {

       $this->context->controller->addJS($this->_path.'views/js/jquery.min.js');
       $this->context->controller->addJS($this->_path.'views/js/bootstrap.min.js');
       $this->context->controller->addJS($this->_path.'views/js/front.js');
       $this->context->controller->addCSS($this->_path.'views/css/front.css');
       $this->context->controller->addJS($this->_path.'views/js/responsiveslides.js');
       $this->context->controller->addJS($this->_path.'views/js/perso.js');
       $this->context->controller->addCSS($this->_path.'views/css/responsiveslides.css');
   }



   public function getSlides($active = null)
   {
    $slides = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
        SELECT *
        FROM '._DB_PREFIX_.'promo_img'
        );

    foreach ($slides as &$slide) {
        $slide['image_url'] = $this->context->link->getMediaLink(_MODULE_DIR_.'promo/images/'.$slide['image']);
    }

    return $slides;
}

public function hookDisplayHome()
{

    $slides = $this->getSlides();
    // $this->smarty->assign('jsslider', '<script>$(function(){$(".rslides").responsiveSlides();auto: false,namespace: "rslides1",nav: false});</script>');    
    $this->smarty->assign('slides',$slides);


    $today = date('Y-m-d');
    $this->smarty->assign('date',$today);

    return $this->display(__FILE__, 'test.tpl');
}
}