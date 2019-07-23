Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A6671BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfGWPkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:40:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:24246 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388432AbfGWPj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:39:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 08:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="193104316"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2019 08:39:57 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpwtQ-0004OM-5z; Tue, 23 Jul 2019 18:39:56 +0300
Date:   Tue, 23 Jul 2019 18:39:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: Use dev_get_drvdata
Message-ID: <20190723153956.GN9224@smile.fi.intel.com>
References: <20190723082933.21134-1-hslester96@gmail.com>
 <CAMpxmJUCPCyC-n9V+o5veMTm-yui8H2vdn1ceqZN=VG+yosLOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJUCPCyC-n9V+o5veMTm-yui8H2vdn1ceqZN=VG+yosLOw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:34:28AM +0200, Bartosz Golaszewski wrote:
> wt., 23 lip 2019 o 10:29 Chuhong Yuan <hslester96@gmail.com> napisał(a):
> >
> > Instead of using to_pci_dev + pci_get_drvdata,
> > use dev_get_drvdata to make code simpler.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/gpio/gpio-pch.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
> > index 1d99293096f2..3f3d9a94b709 100644
> > --- a/drivers/gpio/gpio-pch.c
> > +++ b/drivers/gpio/gpio-pch.c
> > @@ -409,8 +409,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
> >
> >  static int __maybe_unused pch_gpio_suspend(struct device *dev)
> >  {
> > -       struct pci_dev *pdev = to_pci_dev(dev);
> > -       struct pch_gpio *chip = pci_get_drvdata(pdev);
> > +       struct pch_gpio *chip = dev_get_drvdata(dev);
> >         unsigned long flags;
> >
> >         spin_lock_irqsave(&chip->spinlock, flags);
> > @@ -422,8 +421,7 @@ static int __maybe_unused pch_gpio_suspend(struct device *dev)
> >
> >  static int __maybe_unused pch_gpio_resume(struct device *dev)
> >  {
> > -       struct pci_dev *pdev = to_pci_dev(dev);
> > -       struct pch_gpio *chip = pci_get_drvdata(pdev);
> > +       struct pch_gpio *chip = dev_get_drvdata(dev);
> >         unsigned long flags;
> >
> >         spin_lock_irqsave(&chip->spinlock, flags);
> > --
> > 2.20.1
> >
> 
> The subject line should start with gpio: pch: ...

I can change it when apply to gpio-intel tree.

-- 
With Best Regards,
Andy Shevchenko


