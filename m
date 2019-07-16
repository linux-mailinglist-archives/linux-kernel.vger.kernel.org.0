Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF56B27D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 01:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbfGPXrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 19:47:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43057 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbfGPXrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:47:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so3965085pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=aC7GDup6sSVAKynCM4PPlfap2E8VieMEW0LKr0VhP4o=;
        b=EeHwxihVsubbGohI4N+iMq6111QSfBR2+MzTCtvx264JSBHR16jAfPe4Hthrd4LTuh
         D8+U+myItRxfGZ7WwSQQxavWEekV3l2YXjZNJ9HQmm48yYdV41XRuvhFdVFb5xUcXXJJ
         G83vqB8eU8DIZIiXFrEFC/a7Qs3G0KV8I+QYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=aC7GDup6sSVAKynCM4PPlfap2E8VieMEW0LKr0VhP4o=;
        b=mG/IntX7sioIsghnBePm5K8hYipPZtQkQ4ik8yIaVplX2cXriKBedgKHCxcqOP/Cx4
         /hcJ+88/E0Td7QNzi9tCMJ8mS5uEx/89cRlZBVgtAdHqwsQJqz8bFg7iCM6bpbnUwcpc
         r9Vszfg1zqdti9N80f+irxQDU3m/p7slQ75o0Mf0hK3W3gxjwuKwAXQ1uF8z+luCqxeR
         Ufsm7KZutMXSR1c+QAggbRB/qEkpjmCXDp3roPoRZk73wf2TqckIkXXf6LC/JsvYRU6U
         ZAmN4YDggyjUeTSmJGOTMPMnpWtS+tWECuiW8ESsr7y3ZSnVJd9gtUcTtLm6pdmCwyyu
         CLDA==
X-Gm-Message-State: APjAAAX42IwZ/0s6qva0v2CLVHldikb318pX3hRsnvWN0b4RMxPzKCa0
        obvP5OmPnD+cCaPA+vWHHnx1ZQ==
X-Google-Smtp-Source: APXvYqzhSwpvj8qbc+/+34wtpZMVGUuet29RcNzS5bdv1MfaCZ8Kr97xGSbJP/UcEHqXYP8QNdef3Q==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr38965932pls.256.1563320828962;
        Tue, 16 Jul 2019 16:47:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y8sm20547411pfn.52.2019.07.16.16.47.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 16:47:08 -0700 (PDT)
Message-ID: <5d2e61fc.1c69fb81.afb7a.a64a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7299c814-3d9f-c5d1-fe7b-44e05f8b4ec9@codeaurora.org>
References: <20190604222939.195471-1-swboyd@chromium.org> <20190604223700.GE4814@minitux> <5cf6f4bb.1c69fb81.c39da.5496@mx.google.com> <CAFp+6iHZeawnz7Vfk3=Oox-GN_y6c-E9wMwc-qdp1bTOXgqjFQ@mail.gmail.com> <5cf82c6f.1c69fb81.9e342.dbda@mx.google.com> <CAFp+6iE8FUXxexKbYy=ak+se-pj1XXUZxTu5o=hJvg66V6+Rzw@mail.gmail.com> <5cfee60a.1c69fb81.584d9.cf12@mx.google.com> <7299c814-3d9f-c5d1-fe7b-44e05f8b4ec9@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add iommus property to qup1
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 16 Jul 2019 16:47:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vivek Gautam (2019-06-12 02:26:20)
>=20
>=20
> On 6/11/2019 4:51 AM, Stephen Boyd wrote:
> > hardware signal like the NS bit and/or the Execution Level. Hopefully
> > it's a config and then our difference from MTP can be minimized.
>=20
> I don't think SMMU limits any such programming of SIDs. It's a design=20
> decision
> to program few SIDs in TZ/Hyp and allocate the corresponding context banks
> and create respective mappings. You should be able to see these SMR=20
> configurations
> before kernel boots up. I use a simple T32 command -
>=20
> smmu.add "<name>" <smmu_type> <base_address>
> smmu.streammaptable <name>
>=20
> e.g. for sdm845 apps_smmu
>=20
> smmu.add "apps" MMU500 a:0x15000000
> smmu.StreamMapTable apps
>=20
> This dumps all the information regarding the smmu.

Preferably I can see this by using devmem instead of jtag and T32. Do
you know the address of the register? Otherwise I'll go dig into the
documentation and try to figure it out.

>=20
> >
> > As far as I can tell, HLOS on SDM845 has always used GPI (yet another
> > DMA engine) to do the DMA transfers. And the GPI is the hardware block
> > that uses the SID of 0x6d6 above, so putting that into iommus for the
> > geniqup doesn't make any sense given that GPI is another node. Can you
> > confirm this is the case? Furthermore, the SID of 0x6c3 sounds untested?
> > Has it ever been generated on SDM845 MTP?
>=20
> I will get back with this information.
>=20

Any update?
