Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6423F7F6D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 14:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392607AbfHBM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 08:27:42 -0400
Received: from sonic308-56.consmr.mail.ne1.yahoo.com ([66.163.187.31]:39745
        "EHLO sonic308-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388599AbfHBM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1564748860; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=VTUoly0p7ES2Ixq22NviOrwQKzo3BGRr5wX2Ns9PEzCCQlygrMPx+jEX2rcxwC8OtdwKjGxyYWyhv9I236BzILUc3TDf/vrf2VE54WhndHZGo3TN5K2pEnf0TdmpFqL088ZODULGeD7+KkEn+y48KltZDkFHZyMRSlELZrH+C+sjWJjaboWYmnt6qrkjc3xkUW3xkNKw1LM9o4gVElA15jbYGVLLf25Ia1Ghx/tYae9LpsoylIvBndyLFM9KvUfA82gQH1qzIyM9tj+eyR2AdP2Djit4vM9RiiSqqitLMMraB/jKqoiifXbIfGFCvBadU9Hu0L2TlundsqjVRuVjkA==
X-YMail-OSG: LGYhDFEVM1lewJ8rJFRf9kbwMfMjJWBipXC0of3ugQg6Z3AVn3whVS13ZQ5wKit
 yibqZdXVDy2Ee4BaXhns9djvWxERXLJ5lcI3dvZrqINNp9YSvE_GeHd1fmLkvKIeMuOruxcS9gug
 W27RHGx8QQW5vjDy1k2T3I.ocQu.6MPgI_NE7Zt84IJiwt6GD8rwj1kTwGne.RfKeRd.r0FckVco
 mrKUEmngpeknYk0BQUUfM30C_rcoZ78cOG.t.SuDzeMWDK3Tz745EFfVG1LWXYbPLI2f5e.0HUvF
 WAHs5e8w12KIBNi_0i9KCuBaDFV2WzG.n_SeCx1HosdraHQXQPot0EqGV8fxm10btLxoGtw0q4VY
 wUM711kSXgNBw2m8.HuE7rKzzQR.lTZukI21wQ.4NIvnM7c.d8GnSZ4IWsA5qoZSNPtBVJjIy9gP
 1jlqLT2D7HizO9s.XUT9aVOORE4hNXVSUCTzbxJJjS40ep0OqcmPLAnPxIk8LVpVeFhWdOHiQwDQ
 CRcfN0r352C0LePHmbjzKXe0w8zyUGH.nt9o8NUN.mKo74qc0NI3jh4CLCdkbougGABSQZjwdc31
 qAdoGa3Ifr6L_pzbdx5VT8MLFvM_Z2ergqlIG7PpMKsZj1OGXyB_1Mq0AJVWK4Uc.gVXmlAh9e8w
 _yY5oCMZbMq3ASQovb0CZsKsfNDVNOgEFnk7cuMbzUV0Hp6eUaga32.xk7CDB5Hf7y0QQns5zI0a
 qbtFIija40SoiEgWNAiHStS9pN_Wv8fjUJaktBGYQiDE_.rf3NBR5TdIOUlOiH0nWxxHDt4AF.RW
 qv0tj3SH0uliaEJDkScF6gFhrQqBlHe98enJzkHqTwNydIKLB50kPfBgJDfnk3.OKHhEYa76Eb91
 qLWeyfd1aXw9ZBPOYpBQgBY1xdQpGJYNZMXDgJ6c7IF.Ep_9WztQsXN5wiikvGXnTki5CtK9oHQa
 wmtQXtmSSuuA3ThRNUWEHPOuKNK5KDntYmTkyaeAMZPaAF94PemTwo4Zrw7yOb2eGcmK8oUUjX74
 mTH5.PzImziI3AWE2Ht7ECXJPvosMxRjUFHrwN9tNmL9aQvvaSo9oRmDhQu2ZphAG19szTergsSv
 a2.7AnOLkgvvBasZKn4CkxkqeKWDCcziOKD8qGbSQXlF8kCJ8Rf9wBuu8esMFvQGqaPREm26sTXu
 EzbGPdaFo74jVxxNiH9Rly1C3mNH_kcNjcvPgcp9flq1D_zrZJ8vznZY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 2 Aug 2019 12:27:40 +0000
Date:   Fri, 2 Aug 2019 12:27:39 +0000 (UTC)
From:   Aisha Gaddafi <gaddafiaisha25552@aol.com>
Reply-To: gaisha983@gmail.com
Message-ID: <220361650.143829.1564748859288@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
