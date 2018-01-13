USE master;
GO
-- na jakie daty mamy w bazie dane dla danej pary walutowej.
select md.AsOfDate from rate..FxSpotPrice as fx, rate..MarketData as md
 where fx.MarketDataId = md.Id
   and DefinitionId = (select Id from rate..FxSpotPriceDefinition 
                        where RiskFactorMnemonic = 'AAAA')
 order by md.AsOfDate;
GO


