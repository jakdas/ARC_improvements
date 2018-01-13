USE master;
GO
-- kursy pary walutowej na dana date
select md.AsOfDate, fx.SpotPrice from rate..FxSpotPrice as fx, rate..MarketData as md
 where fx.MarketDataId = md.Id
   and DefinitionId = (select Id from rate..FxSpotPriceDefinition 
                        where RiskFactorMnemonic = 'AAAA')
   and md.AsOfDate = 'BBBB';
GO
