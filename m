Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A598180756
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCJSsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:48:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34964 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJSsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:48:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id k26so6971149otr.2;
        Tue, 10 Mar 2020 11:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzS4Ory16y/BLSb6no87Sernjs2m/cGxUWkwz4EtDSw=;
        b=bHrrbkEe93tofoi9fXugjJHRTbU1TMEPmLwDmEpz8kIbcp0BZ0uzFY8CIz2TJE4QcA
         H65GMIhzduUY5GGOIMKxjYW5G3WonEnC9qKqbKjzWdsQRBAc4XAL/1eoLfx8BEn04W/j
         ZSyofGpHSCT2mSnIwTFyM/26ltBHBROy8hLn4gGlZ1nbCI1RoL3V/uV9pIzgqZ5jzH99
         h/rYMYXJseNhVRsU+jZ7eaVF15w0BBvNe8DADxmBi8Ji5M0mhnQB9ciLrFG3Tz/5TmUp
         lgDc37Rm4v7ABAPQjaFOVcyWfL4tLjzYqBi7etHKbbCSgKd9Q6BLr9lQgMjSh1AoMi2R
         emzQ==
X-Gm-Message-State: ANhLgQ0dMupVGjiZ9/kzLLm6Wuk24FFRFTOHdi4y65/YpP2rEAwiaFsm
        O9r+uJ+LLmv2bhyjOtZ1dw==
X-Google-Smtp-Source: ADFU+vsMU183YY5TJ9IDWm2qf6EIOH/EKHLHafJAiNQIT7jZ1BNW3xQAYT9kBEXnBN09EB1NU0f2WQ==
X-Received: by 2002:a9d:750d:: with SMTP id r13mr7271522otk.321.1583866126181;
        Tue, 10 Mar 2020 11:48:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a73sm2633320oib.16.2020.03.10.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:48:45 -0700 (PDT)
Received: (nullmailer pid 15229 invoked by uid 1000);
        Tue, 10 Mar 2020 18:48:44 -0000
Date:   Tue, 10 Mar 2020 13:48:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        olivier.moysan@st.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] dt-bindings: sound: Convert cirrus,cs42l51 to json-schema
Message-ID: <20200310184844.GA15190@bogus>
References: <20200228152706.29749-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228152706.29749-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 16:27:06 +0100, Benjamin Gaignard wrote:
> Convert cirrus,cs42l51 to yaml format.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/sound/cirrus,cs42l51.yaml  | 69 ++++++++++++++++++++++
>  .../devicetree/bindings/sound/cs42l51.txt          | 33 -----------
>  2 files changed, 69 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
