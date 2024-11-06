--- Transacciones de ATM

select timestamp, _interbank.identities.*, _interbank.event_channel_feature.*, _interbank.event_channel.*, _interbank.event_channel_location.*, eventType, _id
from ib_rel_camp_persona_evento_tienda
where _interbank.event_channel.des_canal = 'ATM' 
  --and _interbank.identities.coddoc = '55921D072AA0D754E37B91563A05368A6754BE0E0820A7DE5103FC2F867289C5'
limit 10

--- Evaluación Población Audienci

with ups_audiences_profile_explode as (
  SELECT _interbank.identities.coddoc as coddoc,'ups' as audience_type, EXPLODE(map_entries(segmentMembership['ups'])) as audience
  from profile_snapshot_export_054dbcd3_1357_4643_a941_ed2f6758956e
),
uploading_audiences_profile_explode as (
  SELECT _interbank.identities.coddoc as coddoc,'CustomerAudienceUpload' as audience_type, EXPLODE(map_entries(segmentMembership['CustomerAudienceUpload'])) as audience
  from profile_snapshot_export_054dbcd3_1357_4643_a941_ed2f6758956e
),
audiences_profile_explode as (
  select coddoc, audience_type, audience.key as audience_id, audience.value as audience_data
  from ups_audiences_profile_explode
  UNION
  select coddoc, audience_type, audience.key, audience.value
  from uploading_audiences_profile_explode
)
select audience_type, audience_id, count(distinct coddoc) as profiles
from audiences_profile_explode
where audience_data.status = 'realized' and audience_data.lastQualificationTime is not null
  and audience_id in ('bc2be92d-6f3f-4605-a762-6c629fa107b3','490cde56-2244-4052-a7a3-92425bfba128','9754d811-7607-4d64-8f39-19b8015592bb','8044bbcf-0765-4524-b6f8-88794a41edd2','b6e62f26-183a-4088-94cf-135c64872d07','91310656-5781-4f6c-8eb2-b2dba1d2c19e')
--  and coddoc = '72888A9AFD9D4B739A926D8EB2FCBE0BCA6B957CBD6FD014814A4184C1349B23'
group by 1,2

--- Evaluación Detalle Perfiles Audiencias

with
  ups_audiences_profile_explode as (
    SELECT
      _interbank.identities.coddoc as coddoc,
      _interbank.customer.primer_nombre as nombre,
      'ups' as audience_type,
      EXPLODE (map_entries (segmentMembership['ups'])) as audience
    from
      profile_snapshot_export_054dbcd3_1357_4643_a941_ed2f6758956e
  ),
  uploading_audiences_profile_explode as (
    SELECT
      _interbank.identities.coddoc as coddoc,
      _interbank.customer.primer_nombre as nombre,
      'CustomerAudienceUpload' as audience_type,
      EXPLODE (
        map_entries (segmentMembership['CustomerAudienceUpload'])
      ) as audience
    from
      profile_snapshot_export_054dbcd3_1357_4643_a941_ed2f6758956e
  ),
  audiences_profile_explode as (
    select
      coddoc,
      nombre,
      audience_type,
      audience.key as audience_id,
      audience.value as audience_data
    from
      ups_audiences_profile_explode
    UNION
    select
      coddoc,
      nombre,
      audience_type,
      audience.key,
      audience.value
    from
      uploading_audiences_profile_explode
  )
select
  audience_type,
  audience_id,
  coddoc,
  nombre
from
  audiences_profile_explode
where
  audience_data.status = 'realized'
  and audience_data.lastQualificationTime is not null
  and audience_id in (
    '6c600a76-2de4-421b-9015-f963ada15164'
  )
  --  and coddoc = '72888A9AFD9D4B739A926D8EB2FCBE0BCA6B957CBD6FD014814A4184C1349B23'
limit 100

-- audiences

  select
  _experience.journeyOrchestration.stepEvents.journeyVersionName,
  _experience.journeyOrchestration.stepEvents.journeyVersionID,
  _experience.journeyOrchestration.stepEvents.profileNamespace,
  _experience.journeyOrchestration.stepEvents.profileID,
  _experience.journeyOrchestration.stepEvents.nodeID,
  _experience.journeyOrchestration.stepEvents.nodeName,
  _experience.journeyOrchestration.stepEvents.nodeType,
  _experience.journeyOrchestration.stepEvents.eventID,
  _experience.journeyOrchestration.stepEvents.exportSegmentID,
  _experience.journeyOrchestration.stepEvents.stepID,
  _experience.journeyOrchestration.stepEvents.stepName,
  _experience.journeyOrchestration.stepEvents.stepStatus,
  _experience.journeyOrchestration.stepEvents.stepType,
  timestamp,
  identityMap
from
  journey_step_events
where
  --_experience.journeyOrchestration.stepEvents.profileID = '4293A412D1B7EB9EA0C95A09BAF5B1D4F0BC2F3BEB0D9D9D25BBD675DEE8FF9B'
  --_experience.journeyOrchestration.stepEvents.journeyVersionName like '%SL_202410_GCL_OM_1_0_0_2_MEADQUISICION_VENTA_TC_FRESCOS_1_R0_CXP%'
  --and _experience.journeyOrchestration.stepEvents.nodeName like '%Read Segment%'
  _experience.journeyOrchestration.stepEvents.exportSegmentID in ('bc2be92d-6f3f-4605-a762-6c629fa107b3','490cde56-2244-4052-a7a3-92425bfba128','9754d811-7607-4d64-8f39-19b8015592bb','8044bbcf-0765-4524-b6f8-88794a41edd2','b6e62f26-183a-4088-94cf-135c64872d07','91310656-5781-4f6c-8eb2-b2dba1d2c19e')
limit
  100

-- Journey Steps Profile Quantification

with journey_ids_per_audiences as (
select
  _experience.journeyOrchestration.stepEvents.journeyVersionID as journeyversionId
from
  journey_step_events
where
  _experience.journeyOrchestration.stepEvents.exportSegmentID in ('5f398021-446f-4611-998f-aaf8013a632b')
group by 1
)
  select
  _experience.journeyOrchestration.stepEvents.journeyVersionName,
  _experience.journeyOrchestration.stepEvents.journeyVersionID,
  _experience.journeyOrchestration.stepEvents.profileNamespace,
  _experience.journeyOrchestration.stepEvents.exportSegmentID,
  split(_experience.journeyOrchestration.stepEvents.nodeName,' - ')[0] as nodeName,
  split(_experience.journeyOrchestration.stepEvents.nodeName,' - ')[1] as campaign,
  count(distinct _experience.journeyOrchestration.stepEvents.profileID) as profiles
from
  journey_step_events n , journey_ids_per_audiences b
where 
  n._experience.journeyOrchestration.stepEvents.journeyVersionID = b.journeyversionId
  and _experience.journeyOrchestration.stepEvents.journeyVersionName is not null
  and _experience.journeyOrchestration.stepEvents.profileNamespace is not null
group BY
  1, 2, 3, 4, 5, 6


-- Journey Steps Profile Deta

with journey_ids_per_audiences as (
select
  _experience.journeyOrchestration.stepEvents.journeyVersionID as journeyversionId
from
  journey_step_events
where
  _experience.journeyOrchestration.stepEvents.exportSegmentID in ('5f398021-446f-4611-998f-aaf8013a632b')
group by 1
)
select
  _experience.journeyOrchestration.stepEvents.journeyVersionName,
  _experience.journeyOrchestration.stepEvents.journeyVersionID,
  _experience.journeyOrchestration.stepEvents.profileNamespace,
  _experience.journeyOrchestration.stepEvents.exportSegmentID,
  split(_experience.journeyOrchestration.stepEvents.nodeName,' - ')[0] as nodeName,
  split(_experience.journeyOrchestration.stepEvents.nodeName,' - ')[1] as campaign,
  _experience.journeyOrchestration.stepEvents.profileID as coddoc
from
  journey_step_events n , journey_ids_per_audiences b
where 
  n._experience.journeyOrchestration.stepEvents.journeyVersionID = b.journeyversionId
  and _experience.journeyOrchestration.stepEvents.journeyVersionName is not null
  and _experience.journeyOrchestration.stepEvents.profileNamespace is not null

  select count(*)
from uis_repair_shared_identities
limit 100


select max(timestamp - INTERVAL '5 hour') as time_fixed, count(1) as events
from ib_rel_digital_channel_benefit
limit 100

select max(timestamp - INTERVAL '5 hour') as time_fixed, count(1) as events
from ib_rel_digital_channel_app


select max(timestamp - INTERVAL '5 hour') as time_fixed, count(1) as events
from ib_rel_digital_channel_website


select *
  --timestamp - INTERVAL '5 hour' as time_fixed, _interbank, eventtype, productListItems, environment, application, identityMap, web, eventtype --max(timestamp - INTERVAL '5 hour') as time_fixed, count(1) as events
from ib_rel_digital_channel_website
where eventtype in (
  --'web.webpagedetails.pageViews',
  'web.webinteraction.linkClicks')
limit 100

select timestamp - INTERVAL '5 hour' as time_fixed, _interbank, eventtype, productListItems, environment, application, identityMap, web, eventtype --max(timestamp - INTERVAL '5 hour') as time_fixed, count(1) as events
from ib_rel_digital_channel_app
where eventtype in (
  --'web.webpagedetails.pageViews',
  'web.webinteraction.linkClicks')
limit 100