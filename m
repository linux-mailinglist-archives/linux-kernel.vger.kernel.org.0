Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B34BE1B26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbfJWMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 08:46:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34108 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390104AbfJWMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:46:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id b72so6685555edf.1;
        Wed, 23 Oct 2019 05:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A4xxnHET7dHUr6+FUOOYWQtG2S2xuT97YaAB9hJ4Qfs=;
        b=W1KbQtpmWt/MKHEj4j+1dunbkRU3GsIeHmt9O4c6PTD4o5+0m3nkzP/9XKQfMH96LA
         6U1o3t7Ji/LjmA2FMI4qd2pnpUyUq3/wSFEnREVh/MVym/kiIiJusdzDZs/dpWR6PTgi
         kipHrAzEQBz/AFPEg//hgUbNLRLL89XbYbtGWx0Y/vgyGxuYl/Gfv36N/XyMtss/xHIj
         qemA7p+4rwfj5cemtT9SwMLwUBNNG1EYNvoJB0SiY6S0xdBnFv0gyNFh7mJVMOpGflQ/
         745CQhBcqsggL/DhIw/0vqjSNmEMSryWsasH7vrIPFM9AZmoqvaMiI+Gzi5OuTGasDIQ
         AQ/A==
X-Gm-Message-State: APjAAAV37q8Np60BTXdX8Erm9fpcstLjyWHKQXv8jcZkuZcYrClq47F1
        NpstkAoU6O7Li2HXwAa1Mwc85N9oBE4=
X-Google-Smtp-Source: APXvYqyIj+x4DPnQ8/wfFlKsi+/SJbuj1ZkWeMFOp0eV28T9/zZeeEOdXwSG8Og+Eu/s2dSay0QajQ==
X-Received: by 2002:a50:f683:: with SMTP id d3mr15725304edn.70.1571834810704;
        Wed, 23 Oct 2019 05:46:50 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id d8sm279944edb.18.2019.10.23.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:46:50 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:46:48 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 03/36] usb: gadget: s3c: use platform resources
Message-ID: <20191023124648.GE11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-3-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:47PM +0200, Arnd Bergmann wrote:
> The resources are correctly initialized, so just use them
> instead of relying on hardcoded data from platform headers.

Generic comment to all patches - you seem to break commit msg lines
slightly too early. In certain cases it makes them unnecessarily longer.
Maybe your editor has to be fixed to wrap at 75 column.

Best regards,
Krzysztof

