Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2EBEA03
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 03:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfIZBWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 21:22:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43080 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfIZBWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:22:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so436623pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=MD8PqFTIrfqVg/nPcicHnw4G60xSlz72XwRSvmNFqHw=;
        b=aUJRjKjbUWWfnryhWekM6eT0R9Q0ZW8mYa4Hv/Vl1RsCZoR9N4HMkn2a3DXvpQBJG8
         JaqoOYt5rDFbdhT/QQBUy3GVB9Ag8fwg5OIDAXmZyNeRooRRzAn7zql0WfeYI9Cyy1c3
         v7I1Z69Js3DmPjvPg39AaNy27dxsEJp6ip/UJaxXpYlsbn70A5TkcaecCErWZwk4kWk1
         CtW8N6Apt44DkzwWEKHw4LyPGsJbC9/y5I95zV26bB/mbshREVLcN4PcbT5Qqiiu6Loa
         9oXDdyjXZzjkmYC3hz5CVtrp7pI83WxAXigVW1bBp8LY25eBbYfCjhAQsN5Y7R8P+ouj
         B7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MD8PqFTIrfqVg/nPcicHnw4G60xSlz72XwRSvmNFqHw=;
        b=GqD6CY9gzldAgSdlKRtmbaWqKq7NrSGXmys4i2WGHoE9EfpIePDo+GWm5mM95og7hI
         fbfNWbEztXalbpt4GdhpS5eFCOhZESaPal87xU1BGqjW4qK6bVsjHAZq4FQGSMuHX0GP
         1K/08p6RzjjyDprovHJ7s63VXO5iYja03ZOIaPKXezX3f7WI8Zzf8oH7hyZByjtk3tMc
         0mmLSP/XlxrpxanAC2yfmJtCqF2ZU4P48hdtKvLjJnKuHTpCDl1D8l2xmTxe1jRBjMU9
         3kE/aYwBNHolJK1QlFyI4Z/1ZS7n6QAVNP1+CYUREiWWedpB4jEhdGb609ignO6XnsM7
         d3SQ==
X-Gm-Message-State: APjAAAXgkWLEnopMqrXea16fkMzQ1Z8H++S5EZaGtoNSJ6iUSMRzdBnf
        NgiwgpJuhBdyhkmEj8MKEhXuMA==
X-Google-Smtp-Source: APXvYqwR/3RSURcXKUfDfobDH/x9KWfYdawkfjKylyVeNquiinjS2lN6UzCD3oNi1JQcv37aof7a1A==
X-Received: by 2002:a63:120a:: with SMTP id h10mr769341pgl.29.1569460931530;
        Wed, 25 Sep 2019 18:22:11 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id d5sm272418pjw.31.2019.09.25.18.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 18:22:11 -0700 (PDT)
Date:   Wed, 25 Sep 2019 18:22:08 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        "David S. Miller" <davem@davemloft.net>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Fred Lotter <frederik.lotter@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: flower: fix memory leak in
 nfp_flower_spawn_vnic_reprs
Message-ID: <20190925182208.6b8be6bd@cakuba.netronome.com>
In-Reply-To: <20190925190512.3404-1-navid.emamdoost@gmail.com>
References: <20190925190512.3404-1-navid.emamdoost@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 14:05:09 -0500, Navid Emamdoost wrote:
> In nfp_flower_spawn_vnic_reprs in the loop if initialization or the
> allocations fail memory is leaked. Appropriate releases are added.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Fixes: b94524529741 ("nfp: flower: add per repr private data for LAG offload")

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
