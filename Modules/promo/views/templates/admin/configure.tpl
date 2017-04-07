{*
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
	*}

<!-- 	<div class="panel">
		<h3><i class="icon icon-credit-card"></i> {l s='Module de Promo' mod='promo'}</h3>
		<p>
			<strong>{l s='Here is my new generic module!' mod='promo'}</strong><br />
			{l s='Thanks to PrestaShop, now I have a great module.' mod='promo'}<br />
			{l s='I can configure it using the following configuration form.' mod='promo'}
		</p>
		<br />
		<p>
			{l s='This module will boost your sales!' mod='promo'}
		</p>
	</div> -->

	<div class="panel">
		<h3><i class="icon icon-tags"></i> {l s='Documentation' mod='promo'}</h3>
		<p>
			<table id="promo" class="table table-striped">
				<thead>
					<tr>
						<th>ID</th>
						<th>Image</th>
						<th>Titre</th>
						<th>Description</th>
						<th>Légende</th>
						<th>Date Début</th>
						<th>Date Fin</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>

					{foreach from=$slides item=slide}
					<tr>
							<td>{$slide.id_promo_slides}</td>
							<td><img src="{$slide.image_url}" alt="" style="width: 250px;"></td>
							<td>{$slide.title}</td>
							<td>{$slide.description}</td>
							<td>{$slide.legend}</td>
							<td>{$slide.debut}</td>
							<td>{$slide.fin}</td>
							<td><a class="btn btn-danger" href="{$smarty.server.REQUEST_URI}&id={$slide.id_promo_slides}">X</a></td>
					</tr>
					{/foreach}

				</tbody>
			</table>
		</p>
	</div>

	<div class="panel">
		<h3><i class="icon icon-tags"></i>{l s='Promo' d='Modules.Promo.Admin'} </h3>
		
		<div>
			{if $msg == 2}
			<div class="alert alert-success">
				<strong>Super!</strong> La promotion est ajoutée
			</div>
			{elseif $msg == 1}
			<div class="alert alert-warning">
				<strong>Oups!</strong> La promotion n'a pas été ajoutée
			</div>
			{else}

			{/if}
		</div>

		<form action="" method="post" enctype="multipart/form-data">
			<div class="form-wrapper">
				<div class="form-group">

					<label for="exampleInputEmail1">
						Titre de la bannière
					</label>
					<input class="form-control"  type="text" id="title" name="title" value="{$title}" placeholder="{l s='Entrez un titre' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputPassword1">
						Description de la bannière
					</label>
					<textarea class="form-control" name="description" value="{$description}" placeholder="{l s='Entrez une description' d='Modules.Promo.Admin'}"></textarea>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Légende de la bannière
					</label>
					<input class="form-control" type="text" id="legend" name="legend" value="{$legend}" placeholder="{l s='Entrez une légende' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Lien de la bannière
					</label>
					<input class="form-control"  type="text" id="url" name="url" value="{$url}" placeholder="{l s='Entrez une image_url' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Début de la promotion
					</label>
					<input class="form-control datepicker" type="text" id="debut" name="debut" value="{$debut}" placeholder="{l s='Date de début promo' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Fin de la promotion
					</label>
					<input class="form-control datepicker" type="text" id="fin" name="fin" value="{$fin}" placeholder="{l s='Date de fin promo' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputFile">
						Image
					</label>
					<input id="image" type="file" name="image" />
					<p class="help-block">
						Example block-level help text here.
					</p>
				</div>

				<div class="panel-footer">
					<input type="submit" class="btn btn-success" value="Ajouter une promo" name="submitNewsletter" />
				</div>
			</form>


		</div>

		{$jsdata}
		{$cssdata}
		<script type="text/javascript">
			$(document).ready(function(){
				$('#promo').DataTable();
			});
		</script>