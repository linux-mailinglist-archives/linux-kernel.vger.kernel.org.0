Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304D2134E51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 22:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgAHVCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 16:02:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36172 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAHVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:02:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id 19so5017444otz.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 13:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uIbTO+scLpMtdyQX4VTD0iVt1QuxcxYNeAASTguI5Fc=;
        b=m6fNaa7VgLU5DMdjaH2zmzkRLrH0CihfZIMm2ZR4dSpDF+8AQbKYk7098USR7OxW90
         ma71AY0AgnpKDuqlq8Eu5B9wZiV0XAH8WsZF8EVUHTPsxOAkGd8dG8wf4RteAenT/E50
         WhxKnhLwZVGpxBBCXu1VUrzPB6B60vbbWerDZSosNwFFRZZfBwDZRdZywLW/vWRpUVaH
         CJ5zm3UGPltTopTqIRegnUE6Gfp4L2ccV3rEeeSqGW84v8yAQ5tc4oSo1T/HvWfD+y/9
         xWGjX9U+tNf642YPPpmphKc3oSBBXjA4rCKwyyDAz2/P2h5nTBlBG0IGyqxWLPm71B+7
         Rnpg==
X-Gm-Message-State: APjAAAXvG+0mUb5il5AMiWVdLDZ2vALfkgE0xu9f6c0C+JhhyVX2ZqKE
        VO2/jOh0eCLNV6Zxmuba5jf53mc=
X-Google-Smtp-Source: APXvYqzm4FRE/Syt/9rQjoQTGzuHIczJi25iHkVCLM4Tvpr32FjCJB9aeMp8Lnsjd+Iw55LRj8EB/Q==
X-Received: by 2002:a9d:7501:: with SMTP id r1mr5932972otk.196.1578517331258;
        Wed, 08 Jan 2020 13:02:11 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p184sm1461382oic.40.2020.01.08.13.02.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:02:10 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 15:02:09 -0600
Date:   Wed, 8 Jan 2020 15:02:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt: bindings: add vendor prefix for Kamstrup A/S
Message-ID: <20200108210209.GA27864@bogus>
References: <20200107141143.11838-1-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107141143.11838-1-bruno.thomsen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 15:11:38 +0100, Bruno Thomsen wrote:
> Kamstrup manufactures meters for electricity, heating, cooling
> and water. Including long-life communication infrastructure
> for e.g. smart grid based on Linux, more information on
> https://www.kamstrup.com
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
