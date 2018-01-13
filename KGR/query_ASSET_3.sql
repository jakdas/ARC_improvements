USE master;
GO
-- kursy akcji (asset) na dana date
select md.AsOfDate, asset.Price from rate..AssetPrice as asset, rate..MarketData as md
 where asset.MarketDataId = md.Id
   and DefinitionId = (select Id from rate..AssetDefinition 
                        where RiskFactorMnemonic = 'AAAA')
   and md.AsOfDate = 'BBBB';
GO



