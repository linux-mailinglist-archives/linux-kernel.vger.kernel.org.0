Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C854D6F6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 03:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfGVB1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 21:27:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:1716 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfGVB1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 21:27:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2019 18:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,292,1559545200"; 
   d="scan'208";a="320541601"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2019 18:27:39 -0700
Date:   Mon, 22 Jul 2019 09:27:50 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shravan Kumar Ramani <sramani@mellanox.com>,
        LKP <lkp@01.org>, David Woods <dwoods@mellanox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [gpio] f69e00bd21: unixbench.score -24.2% regression
Message-ID: <20190722012750.GB50506@shbuild999.sh.intel.com>
References: <20190710121518.GR17490@shao2-debian>
 <CACRpkdYmtgO_E-KKE8zjA04POawJ=4RN3xFUPY__7GF+gSNbNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYmtgO_E-KKE8zjA04POawJ=4RN3xFUPY__7GF+gSNbNQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Jul 17, 2019 at 05:42:15AM +0800, Linus Walleij wrote:
> On Wed, Jul 10, 2019 at 2:15 PM kernel test robot <rong.a.chen@intel.com> wrote:
> 
> > FYI, we noticed a -24.2% regression of unixbench.score due to commit:
> > commit: f69e00bd21aa6a1961c521b6eb199137fcb8a76a ("gpio: mmio: Support two direction registers")
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> That's pretty bogus since the test doesn't even seem to be using GPIO.
> Further AFAIK Intel chips don't even use that driver.
> 
> Can you provide some rootcausing?

We did some further check, and found this is a false alarm. That some recent 
change to LKP itself has enabled the latencytop for newer kernel(post 5.1-rc1),
and latencytop is known to bring extra system load to scheduling related
benchmarks like unixbench, which caused this -24.7 difference of unixbench
score. Sorry for the noise.

Thanks,
Feng


> If you are using GPIOs from userspace in the test somehow I am
> sure both me and Bartosz would be interested to hear how.
> 
> Yours,
> Linus Walleij
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
