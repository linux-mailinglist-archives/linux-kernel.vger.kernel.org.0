Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983EE2022F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfEPJHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 05:07:38 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:44110 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:07:37 -0400
Received: by mail-pl1-f174.google.com with SMTP id c5so1289418pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rk6cbGmXGHINFsklqOv+u5I1Z/NYxwRIua/RNgDjwj8=;
        b=bUMog77PzyVOMEq1iqZb9z/ph7bE5eMjxAIeFGsnhcgIa0X7FAEpb7FklFo3o3BqEU
         BlsaXgmOhYib+56AySD74oqLmgV6fBvnje2ewWuZFX1YV8okcOaGzL14tdK7PPvJk5rX
         MbD+0eiPSficoyGcuv/kN118EeFDJvYJv28+UucN/lY39+A/MO40MMGdTQg6bzh8rL1N
         vX0A/Tw13cPXakTjJ91Sfhe3nBxCFBDzViNLexx7JpQuoRu8fsqQ4FrH5llW/W+y/KJj
         Dmj+vRHAeGntnswynfhyrAiGzU2byS4AEmaKEWEBTsYUS/die+7JxNxxhtvi2np98MrK
         2xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rk6cbGmXGHINFsklqOv+u5I1Z/NYxwRIua/RNgDjwj8=;
        b=CXdZEEON5DqmcqneclEjcf5//jQy19k0bZbkBeSqOGAtuyNKg02Z8Uex38d33jsLVV
         96Q/fLvJ11djJp3rOt9AwvHXM+P4zIF5tZNYjJfY+3/VFg3GqUVq9rAQtl8KjkTJfG3f
         04HFNadl41+aKDUeAniQXpF8hpkw/+cvkEBTR4bN4G0ccOz0W7sZpLvauagfwCklpDrj
         LrD3+zMXKt1a8ujXsh3z7l90YzQ4KYxOOMf/09EVYDpw8KsdPopnLhfoqtKTfCyoyK7C
         wsU2Lej8F0sX3D1u9cA5WoMpWi+XpJJx4PdjAjsfLy00k6CIjbH3ndWJ2iYEHOY1NGcQ
         X6uA==
X-Gm-Message-State: APjAAAXG/TbtUwIid57U/yhINiMmqye1B+33ajeG8n0B6+TFOQfoy6+T
        7WRe1uTuLo+F1hE9ZqvbpiKh2f6R/Bk=
X-Google-Smtp-Source: APXvYqxP1d84j80Uj3hDqtTgasnJPEoeA+RZpgdQL9//twbA7wHzOGA+/AKIEcbySQOne6QrjXu5TA==
X-Received: by 2002:a17:902:163:: with SMTP id 90mr49879566plb.212.1557997657302;
        Thu, 16 May 2019 02:07:37 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e5sm6660050pgh.35.2019.05.16.02.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 02:07:36 -0700 (PDT)
Date:   Thu, 16 May 2019 17:07:26 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190516090726.GA3283@zhanggen-UX430UQ>
References: <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
 <20190511060741.GC18755@kroah.com>
 <20190512032719.GA16296@zhanggen-UX430UQ>
 <20190512062009.GA25153@kroah.com>
 <20190512084916.GA4615@zhanggen-UX430UQ>
 <20190513073619.GA5580@kroah.com>
 <20190513093730.GA4487@zhanggen-UX430UQ>
 <20190513095809.GA4588@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513095809.GA4588@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:58:09AM +0200, Greg KH wrote:
> qemu should work just fine, I don't know what else to suggest.  Run it
> on "real hardware" with a kmalloc function modified to fail this
> allocation?
> 
> good luck!
> 
> greg k-h
I don't think we need to unwind the loop. The loop condition 
MIN_NR_CONSOLES is defined as 1 in include/uapi/linux/vt.h. In this
situation, should we free other memory except vc_cons[currcons].d, vc
and vc->vc_screenbuf?
Thanks
Gen
