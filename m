Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55D61632B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 21:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgBRULN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Feb 2020 15:11:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:2984 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRULM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:11:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 12:11:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,457,1574150400"; 
   d="scan'208";a="382569617"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2020 12:11:12 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 12:11:11 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.108]) with mapi id 14.03.0439.000;
 Tue, 18 Feb 2020 12:11:12 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] #MC mess
Thread-Topic: [RFC] #MC mess
Thread-Index: AQHV5oFaNSfU2AXDXU6dRUAZO7v/0KghQszggACi3QD//3tUsA==
Date:   Tue, 18 Feb 2020 20:11:10 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F57BDFB@ORSMSX115.amr.corp.intel.com>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218200200.GE11457@worktop.programming.kicks-ass.net>
In-Reply-To: <20200218200200.GE11457@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Then please rewrite the #MC entry code to deal with nested exceptions
> unmasking the MCE, very similr to NMI.

#MC doesn't work like NMI.  It isn't enabled by IRET.  Nested #MC cause an
immediate reset.  Detection of nested case is by IA32_MCG_STATUS.MCIP.
We don't clear MCG_STATUS until we are ready to return from the machine
check handler.

-Tony
