USE master;
GO
-- na jakie daty mamy w bazie dane dla danej akcji (asset).
select md.AsOfDate from rate..AssetPrice as asset, rate..MarketData as md
 where asset.MarketDataId = md.Id
   and DefinitionId = (select Id from rate..AssetDefinition 
                        where RiskFactorMnemonic = 'AAAA')
 order by md.AsOfDate;
GO



