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
						<th>Lien</th>
						<th>Date Début</th>
						<th>Date Fin</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>

					{foreach from=$slides item=slide}
					<tr class="ligne-{$slide.id_promo_slides}">
						<td id="id_promo_slides">{$slide.id_promo_slides}</td>
						<td><img src="{$slide.image_url}" id="img" alt="" style="width: 250px;"></td>
						<td><span id='title'>{$slide.title}</span></td>
						<td><span id='description'>{$slide.description}</span></td>
						<td><span id='legend'>{$slide.legend}</span></td>
						<td><span id='url'>{$slide.url}</span></td>
						<td><span id='debut'>{$slide.debut}</span></td>
						<td><span id='fin'>{$slide.fin}</span></td>
						<td><button type="button" onclick="editPromo('{$slide.id_promo_slides}')" class="btn btn-info" id="{$slide.id_promo_slides}" data-toggle="modal" data-target="#myModal"><i class="icon icon-pencil"></i></button> <a href="{$smarty.server.REQUEST_URI}&id={$slide.id_promo_slides}"><button  class="btn btn-danger"><i class="icon icon-close"></i></button></a></td>
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

		<form action="" method="post" id="formadd" enctype="multipart/form-data">
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
					<input class="form-control datepicker" type="text"  name="debut" value="{$debut}" placeholder="{l s='Date de début promo' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Fin de la promotion
					</label>
					<input class="form-control datepicker" type="text" name="fin" value="{$fin}" placeholder="{l s='Date de fin promo' d='Modules.Promo.Admin'}"/>
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
					<input type="submit" class="btn btn-success" value="Ajouter une promo" name="addPromo" />
				</div>
			</form>


		</div>


		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Modal Header</h4>
					</div>
					<div class="modal-body">
						<form action="" method="post" id="formupdate" enctype="multipart/form-data">
						<input type="text" id="eid" name="eid" value="{$eid}" style="display: none;" />
							<div class="form-wrapper">
								<div class="form-group">

									<label for="exampleInputEmail1">
										Titre de la bannière
									</label>
									<input class="form-control"  type="text" id="etitle" name="etitle" value="{$etitle}" placeholder="{l s='Entrez un titre' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputPassword1">
										Description de la bannière
									</label>
									<textarea class="form-control" id="edescription" name="edescription" value="{$edescription}" placeholder="{l s='Entrez une description' d='Modules.Promo.Admin'}"></textarea>
								</div>
								<div class="form-group">

									<label for="exampleInputEmail1">
										Légende de la bannière
									</label>
									<input class="form-control" type="text" id="elegend" name="elegend" value="{$elegend}" placeholder="{l s='Entrez une légende' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputEmail1">
										Lien de la bannière
									</label>
									<input class="form-control"  type="text" id="eurl" name="eurl" value="{$eurl}" placeholder="{l s='Entrez une image_url' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputEmail1">
										Début de la promotion
									</label>
									<input class="form-control datepicker" type="text" id="edebut" name="edebut" value="{$edebut}" placeholder="{l s='Date de début promo' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputEmail1">
										Fin de la promotion
									</label>
									<input class="form-control datepicker" type="text" id="efin" name="efin" value="{$efin}" placeholder="{l s='Date de fin promo' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputFile">
										Image
									</label>
									<input id="eimage" type="file" name="eimage" />
									<p class="help-block">
										Example block-level help text here.
									</p>
									<p>
									<img src="" id="aimage" alt="" style="width: 250px;">
									</p>
								</div>


							</div>
							<div class="modal-footer">
								<input type="submit" class="btn btn-success" value="Editer une promo" name="editPromo" />
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</form>
						</div>
					</div>

				</div>
			</div>


			{$jsdata}
			{$cssdata}
			<script type="text/javascript">

			$(document).ready(function(){
					$('#promo').DataTable();
				});



				function editPromo(promo){
					$(function() {


						var button = promo;


						$('button[id="'+ promo +'"]').each(function(){
							// var id = $(this).parents('td').text();
							var id = $(this).parent().parent().find("#title");
							var id2 = $(this).parent().parent().find("#description");
							var id3 = $(this).parent().parent().find("#legend");
							var id4 = $(this).parent().parent().find("#url");
							var id5 = $(this).parent().parent().find("#debut");
							var id6 = $(this).parent().parent().find("#fin");
							var id7 = $(this).parent().parent().find("#img");
							$('#etitle').val(id.text());
							$('#edescription').val(id2.text());
							$('#elegend').val(id3.text());
							$('#eurl').val(id4.text());
							$('#edebut').val(id5.text());
							$('#efin').val(id6.text());
							$('#aimage').attr("src", id7.attr("src"));
							$('#eid').val(promo);
						});

					
				});


				}
		
			</script>