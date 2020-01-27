Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E114A84A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgA0Qpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:45:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37092 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0Qpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:45:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id z64so7282015oia.4;
        Mon, 27 Jan 2020 08:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qjocpJAxA81IVt1bUmufDITg+GzjDlPdLwgQfGnaP7c=;
        b=l2NrnwXB9Sw+uhjIEGB5+rkj9YDeI+zCBE30oDBsfXoF7tNAUmRqcoJ38G7kpqalgp
         hIeyRG/A0OmH4Owo/fkk8qGZh9pT+8XzZ8ea3+nREuNj+RGRPts9jp0ALG3G4EIA6IYc
         L3Up3fuGeE2g4diTBZJndqvkRVdjdgOMIRDXznWoz5QrOPzA/3X4H+yrrpN0sk9WmcZr
         7gDXrWEJjGFO7E15P7uyIRYK2d8PKKARlO13U/J4OsQdDdAG7ngKnwE2YZvOaE53vD5S
         RDXXlXTxjl6xm0OIWuwllBH1umKla/uazXDX0449gVgkEQYD50b6lDvmoNn+6KL6fYka
         nzPA==
X-Gm-Message-State: APjAAAWvipP81ViXNiHKl+3zR51ZlJTVwFlIQ8/7JBuAtycPtgv486sR
        7FTxfPhtABdP6PDrnUifDQ==
X-Google-Smtp-Source: APXvYqwz9akG8oXLqrPsCNC1PhlGDchvLiGOlcKR5KH6Pud9QkCqtorHesxJwSnXfGprXw/Lb4yibQ==
X-Received: by 2002:a54:4e8d:: with SMTP id c13mr7972010oiy.27.1580143540313;
        Mon, 27 Jan 2020 08:45:40 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm2316807oie.18.2020.01.27.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 08:45:39 -0800 (PST)
Received: (nullmailer pid 32076 invoked by uid 1000);
        Mon, 27 Jan 2020 16:45:38 -0000
Date:   Mon, 27 Jan 2020 10:45:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, mark.rutland@arm.com, maxime@cerno.tech,
        jsarha@ti.com, tomi.valkeinen@ti.com, praneeth@ti.com,
        mparab@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v3 13/14] dt-bindings: phy: phy-cadence-torrent: Add
 subnode bindings.
Message-ID: <20200127164538.GB7662@bogus>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
 <1579689918-7181-14-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579689918-7181-14-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:45:17AM +0100, Yuti Amonkar wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
> 
> Add sub-node bindings for each group of PHY lanes based on PHY
> type. Only PHY_TYPE_DP is supported currently. Each sub-node
> includes properties such as master lane number, link reset, phy
> type, number of lanes etc.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Also, if you send patches from another author, your S-o-b should also be 
present.
