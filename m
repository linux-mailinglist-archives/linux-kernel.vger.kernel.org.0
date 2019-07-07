Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9FA61572
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 17:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfGGPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 11:46:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42048 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGGPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 11:46:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id a10so13335599wrp.9;
        Sun, 07 Jul 2019 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bGbtCUO4BOGVmzuMetixQhEWqFmuXemkUETV1bb996A=;
        b=HurwfdDW3WShikoqlGrI+gydUdaNqT7nPbx+UlqF+z+96uFR0gEOxu7vwrwEIcA652
         2vLX1bspJ3g8K3J1VtUAGpR5FCLx9lLvut88FGuKNVLFdX/2lcoTuwUtN+fRSAFZA06C
         h3kZvDezlWrGwrV5wdCB3lIDTpAJgeXke0hpev1TE61jvqFG5Q8yBYNszPBPzyqCXmkY
         wILy7HTrAmn8ZexDHsiSOrgg93jeFW6C/CdXiocgdhKz2/Y0n1edjGs0EC7XaJNuoUsF
         ONWgtki6SDtg6krR9585ICxqV98f6NBs1JiTf3jw1DHeSzMNm1n2D6Ho5zQPOBX0SNgp
         oUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bGbtCUO4BOGVmzuMetixQhEWqFmuXemkUETV1bb996A=;
        b=EexSvyJElWDOYWadK3JhnrNo4/Kdo+wytPLV4ruLPYSd65hvJRWSmBNGBmKAftIh8W
         t/WoQYgGoKc7PE2fGYWlWKul3FncyRS7xGFnx+oNcy4bl8rplzRdWOWF7bf8xjMrvvhB
         ZUv3ay+GyN8R16c7sL3bwrK/4z79fiFuBgFfxWnf2nfis9tfG8UZ5BH20pfFB9yOdMz6
         NORVT8RwccuIDiapw8r5cQQO5t44A0gvvUp301Wlphud3cmkirGlJwuKgrXqH13JIGWU
         QwUI0B5jXccJPDq3oLo/mEnwgnbDUbiI7P+WSLjNHayxkiWWBjSXL+yqMztTdMo5WSOy
         qEMA==
X-Gm-Message-State: APjAAAXgQtJ4vcVONbqoUnT4yPGSe4glVLFPx4a8whu1NZb63qffSNN9
        kAeluJaIgEsSrBSex6QTiDk=
X-Google-Smtp-Source: APXvYqw9VqMOs+dnAC5XrgWMcL+6DE/EqrdzKGc6ZeBG3yR+KiuAuikZUZouVTyX/acHxAB3S/hQsw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr4824387wrr.5.1562514384972;
        Sun, 07 Jul 2019 08:46:24 -0700 (PDT)
Received: from arks.localdomain (179.red-83-58-138.dynamicip.rima-tde.net. [83.58.138.179])
        by smtp.gmail.com with ESMTPSA id f17sm9779586wmf.27.2019.07.07.08.46.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 08:46:24 -0700 (PDT)
Date:   Sun, 7 Jul 2019 17:46:17 +0200
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] irqchip: Add Realtek RTD129x intc driver
Message-ID: <20190707154617.GA18436@arks.localdomain>
References: <20190707132256.GC13340@arks.localdomain>
 <baeb2dd8-0382-01ad-514b-982c0f123e6e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baeb2dd8-0382-01ad-514b-982c0f123e6e@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2019 at 03:27:16PM +0200, Andreas Färber wrote:
> Am 07.07.19 um 15:22 schrieb Aleix Roca Nonell:
> > This driver adds support for the RTD1296 and RTD1295 interrupt
> > controller (intc). It is based on both the BPI-SINOVOIP project and
> > Andreas Färber's previous attempt to submit a similar driver.
> 
> Doing that without my Signed-off-by and Copyright is certainly not okay.
> It is also lacking a clear description of what you changed from my last
> submission or the post-submission GitHub version adressing review
> comments, which broke.

I'm really sorry about that, because I rewrote the code (almost) from
scratch (given that I wasn't aware of this previous attempt when I
started working with it) I was not sure if it was necessary. I will
address this in the next version of the patch series.

Thank you and sorry for the inconvenience.

> 
> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
