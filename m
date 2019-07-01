Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E61D045
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfENUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 16:03:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44586 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:03:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id z65so43421oia.11;
        Tue, 14 May 2019 13:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fr00WeJI7LuY/N4++pQHRnJwZ0q8ePUBZpSaqAUAGZM=;
        b=oQfyaUnnrQeGZN4T3LbSgGMZlAnUjyB5MBmCZqABsmil5LfoguTsaqprlVy+g9Vyyz
         o4ztLrHRQX7r5FHcuIU4Y5osg3coXkSshLoc4KgURMdqLHPpODkd7wrZaMkmcEnVaPa3
         wyB91XT0i5zDXCxBDmA9j6DiSvQZXwlRxsg+Ki2O8LAqO2tAVhZpRzGZmPGo9JyZttZ2
         QQaV0GY6wC57IxERLB6n+mgNrYDJ+z2UUsLXPQaLrVjM4XdTUlVOjScGjwH6G6MRGkPw
         UnS1WPK6MyabskaMQ2Gv6hQ9L6Cf1IsT8WpHOuvGy/kzLf0KZGwT8eQxbUDcT5JiOESc
         5g8A==
X-Gm-Message-State: APjAAAVVPp/O4ltoXzlPTG+PSqKoK2oCfVEG+eDCA9/U7UKo8KpuOD3p
        zq6WPXNkSu2WsPj2igjz/g==
X-Google-Smtp-Source: APXvYqyyGrngDLkf4JtW5jGewq3pbgcF+xgmfak6/x/AXfJYI3EEMCP71iIcdP81e9ElCqbZBI7PHw==
X-Received: by 2002:aca:56c3:: with SMTP id k186mr4070933oib.95.1557864184052;
        Tue, 14 May 2019 13:03:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e133sm6577619oif.44.2019.05.14.13.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:03:03 -0700 (PDT)
Date:   Tue, 14 May 2019 15:03:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yannick =?iso-8859-1?Q?Fertr=E9?= <yannick.fertre@st.com>
Cc:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: display: stm32: add supply property
 to DSI controller
Message-ID: <20190514200302.GA10115@bogus>
References: <1557498023-10766-1-git-send-email-yannick.fertre@st.com>
 <1557498023-10766-2-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1557498023-10766-2-git-send-email-yannick.fertre@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 16:20:19 +0200, =?UTF-8?q?Yannick=20Fertr=C3=A9?= wrote:
> This patch adds documentation of a new property phy-dsi-supply to the
> STM32 DSI controller.
> 
> Signed-off-by: Yannick Fertr� <yannick.fertre@st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
