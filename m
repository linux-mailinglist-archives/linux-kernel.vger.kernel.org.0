Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5687110E2B4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfLARFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 12:05:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:37346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfLARFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 12:05:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 383F7ACB1;
        Sun,  1 Dec 2019 17:05:43 +0000 (UTC)
Date:   Sun, 1 Dec 2019 09:01:15 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, mceier@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
Message-ID: <20191201170115.molqadzebqo2sldu@linux-p48b>
References: <20191127005312.GD20422@shao2-debian>
 <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
 <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
 <20191201104624.GA51279@gmail.com>
 <20191201144947.GA4167@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191201144947.GA4167@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Dec 2019, Ingo Molnar wrote:
>So the correct parameter to use in the interval tree searches is not
>'end' but 'end-1'.

Yes absolutely, I overlooked this in the final conversion. Going through some
older conversions, I had this end-1 at one point. Lookups need half-open intervals,
consistent with what memtype_interval_end() does.

[...]

>Patch is only lightly tested, so take care. (Patch is emphatically not
>signed off yet, because I spent most of the day on this and I don't yet
>trust my fix - all of the affected sites need to be reviewed more
>carefully.)

As a general note, this is rather consistent with how all interval-tree
users that need [a,b) nodes use the api.

Thanks,
Davidlohr
