Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB69872F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 09:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405777AbfHIHac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 03:30:32 -0400
Received: from sonic309-22.consmr.mail.ne1.yahoo.com ([66.163.184.148]:41273
        "EHLO sonic309-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405617AbfHIHac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1565335831; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=rf4naa26XUKZaKeKUJDVFEpUaW2Ehr8Nzx0e34SXV+bUUaNTCCZRjh2qPzE56jkNTgJZrIpmjUw5aTysw1618Pa8prXxrJt+Zw2YdEG5KBv7unhTKn3kU7IYPMt+0c1yQVp4Nv2LBahkEpJec6apb5ujyHkwLc5ikAAtYUH0NggU2VNnLfeCCG75CniZDbAl0rWk95nRqr6ktFJB/QgUiJimpyI00LKJEDPy66CATVMgnL6nUsNKxziL8zr3rMZKv6U5jimpmLr/QSPHEvX48v9xUuxlUhk1E0bcIOTb0dKRkPd1mf6lLedn8ygg9shjneOqIBy7uLySZ0HdQd9VGw==
X-YMail-OSG: K7v19REVM1nGvWXbneYT.G2x34un_3.OGbUYL181pbcLcHyePtlLUtaWugOeZw8
 0195QCFQSyUugaxnZH.ug8t2qQXxU0jEXgxVMvbqa3qeQ7qcuU8FktdQfN7SQk6KQ0Zj0HgwfNf2
 kiIOGGPfg16ZMnR4F3INMCGdwAJd2B1RWyEmVNoidw.4ykUHxO_HRfVZ5xI5Pk9CKv1VlI6bS_Tq
 myMJ9wqjChjJbebH1hQ73II.s29.Hm0DPq0j066CZzHLaNR57BLL4a18rF1Gd7mIae4FvBzfwT2o
 HRaRHskvpoprSRJ.B41AmPPsfcynG2WVu5KNA_m6vaJ3MYMgHcpM2yjzGW5s.foeUtTWQxGy09Ke
 DbZzNw056gCSPE7UILSfhYp5q1q3PWQLRsUmLpqlH1t4eKXr8uW__Xo7WbKUdZ1whS7fXy7a6fIT
 E9lIJMQ.ViSPpU2O.4clDJ336gs0ArOaJs0SxRvTCYFUp8ysGcWrvXGdM7DvOPgwirmp91Fyxuej
 wESx3ikACEbQxElm4sGpJ0mupRxaI01c7ipwLnNHtnFZqKEaMiDjq1sboyJWs.9k_xLY5Jcfdg1.
 x.wy9DivsaV48YRWPCB_NkhjvTR9MWHO2VtgQvrHLam4U2ZXJsuKeoQA7UkThCBOuOsF7Fnb6T8G
 aPAFVrMmBpkq5DYlbeugijSBTUDeQFtP0JfRTrGlmbOcegAqV3xPTQcM9h_zBszwkFKBsX6pZL55
 9DdH2DlJ5EfA6JJB3DqtXmtzdJalp.FGTShCiwVvUkWmCJkPCM9dop0qBVfuV2UysakBRdJ_xki8
 p0UttDLzJbZRSneHYMlI7H1CCPy0PHvS5cPX39acqFNAN3zqJNNuG0spRJa1vvZPALDokNBwzRc2
 jKY5Dhhsb4evUvsQ5s416obbp6M7QxQIUTu6EnN1P_j9Qh02ywUJXO5KqVjcv9JFt3XSzfgDxj3g
 1t0boNimJi0efAldNaq9pgNOSdDrtVm01F7hv0VYIUhNSTNZ.66x2BXA0KQw6JpgIKG.PWP5wsvS
 qXsWbQM5PjF.1cDS5tMDQout7rSsOO8iROIXGfxsyP62z0YHz6u_cKsYLQSHUOkdk5ikpDPvAbEh
 Im3ZJoVXgLOU82euyGc2d5tSv0plpASzTM3xVKQbasINDM.qezVxBSGm3DOVyBb_tcbFwAb6i1RH
 Tble7RvBcSjLbzPSYUqoqz5.8GjmKGI6fg3k5xgmZ7EnQ4Dd0ozgRub4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Aug 2019 07:30:31 +0000
Date:   Fri, 9 Aug 2019 07:30:26 +0000 (UTC)
From:   Aisha Gaddafi <gaddafiaisha25552@aol.com>
Reply-To: gaisha983@gmail.com
Message-ID: <645747930.3169670.1565335826594@mail.yahoo.com>
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
