Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9AF13B5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 00:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgANXaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 18:30:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45944 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgANXaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:30:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so13607638oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 15:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fIrwJWeNixjwwvurnQiJ8LKkUrdrIhXQmbfrBg5Oibw=;
        b=sms56Ht5Wo+R1xoGdIRRYaCNta2mqK+EJIW5RKeIAALPSQ22O5S2PhS45iD+o8rokf
         0m9FPwW6AYgQZsyXW1h+fdptQtczPT2J6+0/EjdFWamYq5GAsog0KV+25j5/KuPzAOoI
         oCydGfBsBNwPEE0/PN0fb2mcFXLxU3SpMO3zHQxPk15xeLJ0ybBD451RSWaD9+bcuWxp
         nP6AVH7nHkAmsLmYb1dbAg1lNyhaCwCmMr7zfKP4EovZRTSngM/TuJadSfd4IuluF2Ez
         zgMCY4UO01DUEOnAg6tIkE0UL3Q4ncsYO23gvZlhUO3ENuzKXtAxL4iiLyGZy5MVKn3C
         L70w==
X-Gm-Message-State: APjAAAVja5lwxplXTvwifxrG3b5TJEBUBG1pT3rk8l/a7OUZUZsoHVA9
        LYmC1zQgg7FXd6Twy1xuL1F2SrA=
X-Google-Smtp-Source: APXvYqzz92zyrkM4CU+fVbf3q3DLycryo8O/XH402kR0uYtASvSBxqd7p4/iswY8NqXeqUO45O5BSQ==
X-Received: by 2002:aca:d5d3:: with SMTP id m202mr17997590oig.161.1579044612473;
        Tue, 14 Jan 2020 15:30:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n2sm5078077oia.58.2020.01.14.15.30.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:30:11 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:30:10 -0600
Date:   Tue, 14 Jan 2020 17:30:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, hadess@hadess.net,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yannick.fertre@st.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: touchscreen: Add touchscreen schema
Message-ID: <20200114233010.GA21560@bogus>
References: <20200108091118.5130-1-benjamin.gaignard@st.com>
 <20200108091118.5130-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108091118.5130-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 10:11:17 +0100, Benjamin Gaignard wrote:
> Add touchscreen schema for common properties
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2:
> - remove old definition in touchscreen.txt
> - add type for all properties
> - add dependencies between properties 
> 
>  .../bindings/input/touchscreen/touchscreen.txt     | 40 +----------
>  .../bindings/input/touchscreen/touchscreen.yaml    | 83 ++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
