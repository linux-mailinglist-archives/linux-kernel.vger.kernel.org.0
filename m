Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6C327ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfEWKiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:38:46 -0400
Received: from casper.infradead.org ([85.118.1.10]:43136 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HW7kkCxLjbPF73Er62cEjl0sh5kfeFThig0TQRbVBDY=; b=XkQ6ahiZnLge7o52UrZ33qvHP8
        EKq+CIuywgun5hSSyfs4MKaDcFUR+wnLQi4M8Nl01d3IwELqlacpAgm7VqpHc4afeyx9kQPhlVZCC
        66QrPMLM0FPcuMt1cVP5Tg638kUW3AwbV7tkya84+7SMLRFZ+78r8v9uk4JrXHpH3RHWMgsnBgzRC
        mn8gYNmHX2ZIfelUgODrYgd6LWbNtBijQo6myXv1Q9t8EbHn55o72nCkYCO6NQRk4qbbZFY3xQCLh
        OvVWC0rbDk46hCRT/6W0ddgeFwOsLd7HOAJBx8g+AWQuTayyxk0u26lQ2TaWvUX+pESIuc/3TFVT7
        1nln2t5g==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTl7M-0001gk-AL; Thu, 23 May 2019 10:38:36 +0000
Date:   Thu, 23 May 2019 07:38:30 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: Re: [PATCH 0/8] docs: Fixes for recent versions of Sphinx
Message-ID: <20190523073830.388b4868@coco.lan>
In-Reply-To: <20190523101534.cenmf7rexa7gerot@butterfly.localdomain>
References: <20190522205034.25724-1-corbet@lwn.net>
        <20190523093944.mylk5l3ginkpelfi@butterfly.localdomain>
        <877eah7a2k.fsf@intel.com>
        <20190523101534.cenmf7rexa7gerot@butterfly.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 23 May 2019 12:15:34 +0200
Oleksandr Natalenko <oleksandr@redhat.com> escreveu:

> On Thu, May 23, 2019 at 01:13:23PM +0300, Jani Nikula wrote:
> > On Thu, 23 May 2019, Oleksandr Natalenko <oleksandr@redhat.com> wrote:  
> > > Thanks for the efforts. I've run this on top of Linus' tree, and the
> > > only sphinx-related deprecation warning I've spotted is this one:
> > >
> > > /home/onatalen/work/src/linux/Documentation/sphinx/cdomain.py:51: RemovedInSphinx30Warning: app.override_domain() is deprecated. Use app.add_domain() with override option instead.
> > >   app.override_domain(CDomain)
> > >
> > > Otherwise, it builds.  
> > 
> > Please share your Sphinx version (sphinx-build --version).  
> 
> [~]$ sphinx-build --version
> sphinx-build 2.0.1
> 

Same here with vanilla 2.0.0 (installed via pip3):

Running Sphinx v2.0.0
/devel/v4l/docs/Documentation/sphinx/cdomain.py:51: RemovedInSphinx30Warning: app.override_domain() is deprecated. Use app.add_domain() with override option instead.
  app.override_domain(CDomain)

It seems that this message is there since 1.8:

	https://www.sphinx-doc.org/en/1.8/_modules/sphinx/application.html

The fix seems to be trivial: just replace it to:

	app.add_domain(domain, override=True)

Thanks,
Mauro
