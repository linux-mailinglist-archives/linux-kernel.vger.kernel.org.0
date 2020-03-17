Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A97188ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 21:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 16:18:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:37572 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQUSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:18:48 -0400
IronPort-SDR: HuXQ0suMk8C5SSyebRHo0e8w8/BG454BVgFUvEzIDAL462n2/4qc46H0BLcaiy567Z5PNFaui+
 o9Yw9tTBrnKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 13:18:47 -0700
IronPort-SDR: eVT43dyUHqN7iFTsZ9YK8rjvDSABTdR4IS6P5rhjn2TfDdvF5rNdcXK8SRitRHye28FZJTsaoF
 VjppxR7WrGEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="355474703"
Received: from schen9-mobl.amr.corp.intel.com ([10.134.81.123])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2020 13:18:45 -0700
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
 <20200221232057.GA19671@sinkpad> <20200317005521.GA8244@google.com>
 <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
Message-ID: <1075ba53-91ed-2138-89b3-60fbfbd80b57@linux.intel.com>
Date:   Tue, 17 Mar 2020 13:18:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



BTW Joel,

Did you guys have a chance to try out v5 core scheduler?

> - Joel(ChromeOS) found a deadlock and crash on PREEMPT kernel in the
>   coreshed idle balance logic

We did some patches to fix a few stability issues in v4.  I wonder
if v5 still has the deadlock that you saw before?

Tim
