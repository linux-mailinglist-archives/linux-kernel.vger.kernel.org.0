Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1F27A25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfEWKPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:15:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37332 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfEWKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:15:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so5165315wmo.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 03:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fOiVgoN82KE8hZ6hb2y3oHBGCVTmpcagcUclcAWOin4=;
        b=EgldHSJtWW1hGSZ4Kva8TkrFvTZbGQj+3Vfxoa53Nbg48V9e+Iw3lDfORye5K5Naec
         ADT/dEXCVSgSD8cpFEVeXMuPuQj3nSq7lhwJkft+79ZgLQw9IHsaFKaJ0nseWG+LRi4I
         4wsp2EG9YJCmLzPsUYgWu7o4gdq4QSJjSwqmILdhzCLLm23nKY3g4rd5wjEV53rtaxqT
         4HwUjcQ5w68/2501mBgmlewNtAl8iwIKYiCX9DIFw8QR7asFyLYgNIbVcqN3aO682KV0
         b0oYQz44PmIH6Ya+5AmUX0qjA5lCkJDD2E/tCY4WXskWTyeAG4SKqgkOWAUlp6QPfFzK
         XiCw==
X-Gm-Message-State: APjAAAX8sXmsSaz4J6I0kO43gNCC/bmaGszgUEJaNGERRzptbiB/MkIk
        ohqDBD708Rgd0wsoxHP6T4Df3g==
X-Google-Smtp-Source: APXvYqzBOZoHAw42kYYHFQfMTllL8gg9KY4gD1CnZ1zx61rB5Sk4JjLHT3/hnl/FXagEWu53NtIsIA==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr11613624wmd.110.1558606536551;
        Thu, 23 May 2019 03:15:36 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c14sm23252213wrt.45.2019.05.23.03.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 03:15:35 -0700 (PDT)
Date:   Thu, 23 May 2019 12:15:34 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 0/8] docs: Fixes for recent versions of Sphinx
Message-ID: <20190523101534.cenmf7rexa7gerot@butterfly.localdomain>
References: <20190522205034.25724-1-corbet@lwn.net>
 <20190523093944.mylk5l3ginkpelfi@butterfly.localdomain>
 <877eah7a2k.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eah7a2k.fsf@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:13:23PM +0300, Jani Nikula wrote:
> On Thu, 23 May 2019, Oleksandr Natalenko <oleksandr@redhat.com> wrote:
> > Thanks for the efforts. I've run this on top of Linus' tree, and the
> > only sphinx-related deprecation warning I've spotted is this one:
> >
> > /home/onatalen/work/src/linux/Documentation/sphinx/cdomain.py:51: RemovedInSphinx30Warning: app.override_domain() is deprecated. Use app.add_domain() with override option instead.
> >   app.override_domain(CDomain)
> >
> > Otherwise, it builds.
> 
> Please share your Sphinx version (sphinx-build --version).

[~]$ sphinx-build --version
sphinx-build 2.0.1

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
