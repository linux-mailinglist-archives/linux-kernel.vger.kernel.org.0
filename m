Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AB096F04
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 03:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHUBoA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Aug 2019 21:44:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:61730 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfHUBn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:43:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 18:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,410,1559545200"; 
   d="scan'208";a="186092273"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2019 18:43:58 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 20 Aug 2019 18:43:58 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 20 Aug 2019 18:43:57 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.204]) with mapi id 14.03.0439.000;
 Wed, 21 Aug 2019 09:43:55 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     Juri Lelli <juri.lelli@gmail.com>, lkp <lkp@intel.com>
CC:     Juri Lelli <juri.lelli@redhat.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: RE: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Thread-Topic: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer
 with local_lock
Thread-Index: AQHVVyKEhEVKzLBRwE2fFpo1nIcR/qcE1Rpw
Date:   Wed, 21 Aug 2019 01:43:55 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E66249520CA35E@shsmsx102.ccr.corp.intel.com>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
 <201908201356.Pffozrxv%lkp@intel.com>
 <20190820064203.GB6860@localhost.localdomain>
In-Reply-To: <20190820064203.GB6860@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjA3Yjg0YWQtYjE2ZS00ZTk5LWE2ODUtNWQxYzJmYmM1NTRiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiM1FcL3U0YVh4cjdlTk5DelFcL1pZNzgrSEd3c0hheUR1TVZOS05RbWNUdWpIV3p5YXA4QXNhNXM4Zk1sazJXM3FqIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
> local_lock
> 
> Hi,
> 
> On 20/08/19 13:35, kbuild test robot wrote:
> > Hi Juri,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on linus/master]
> > [cannot apply to v5.3-rc5 next-20190819]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system]
> 
> This seems to be indeed the case, as this patch is for RT v4.19-rt
> stable tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v4.19-rt
> 
> I was under the impression that putting "RT" on the subject line (before
> PATCH) would prevent build bot to pick this up, but maybe something
> else/different is needed?
Hi Juri, currently if the mail subject has RFC, we will test it but send report
privately to author only.

> 
> Thanks,
> 
> Juri

