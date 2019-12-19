Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA79126DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 20:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfLSTM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 14:12:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40809 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfLSSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:36:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so567177otj.7;
        Thu, 19 Dec 2019 10:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zivQ+zB9chH5mQdMiQjMKA9RY31jCG6HIj79CgErI2w=;
        b=kAf6ihh9wxbIvATjCIk1XzOueTAb4ILK6QSqWOi+Gn2QSle6Oo4KugnsE/9PreFHgb
         Hh6d/6dYReYu5rty5VKIn4U1+E719XEXUCWyA6HTGpDMVTvO2l+Jj7Nl1WOedUdWsCYE
         mGRHIGhOD+HXYMiQXUuKsUvxtUvSbCZQkaCr2MQCwo0c5DcWDzQbozJN+XpFejHfKCFR
         6ZbPxqt9DXkAjifwP9RKxuJLMzp6UkOSfo5D9FuPVnrD0lcXItvKGkpJQd/oIi6JgplA
         duSIZuPCkkVVEWZw9+aXSBIbbpCH3xAmlv/zUHWDYH6LVLWIZn1STSYuzNvyMKKodhkr
         Ywtw==
X-Gm-Message-State: APjAAAVztAg9dfsLjmjq0d0KrWB4P88MuWnVoif7fwDO6czTP748hFT/
        zXDe2Uw17Z28atTNU22IC+S3vB0YAA==
X-Google-Smtp-Source: APXvYqw33b/AA4V/6L+JZWrNjHnU++RQzimV+ODRfuMYe8enaJtZW+SQb2ERW5KuWVojra9xd/zYhQ==
X-Received: by 2002:a05:6830:1116:: with SMTP id w22mr10593033otq.216.1576780611093;
        Thu, 19 Dec 2019 10:36:51 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id w12sm2371730otk.75.2019.12.19.10.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:36:50 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:36:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: move sprd board file to vendor
 directory
Message-ID: <20191219183648.GA11279@bogus>
References: <20191209114404.22483-1-zhang.lyra@gmail.com>
 <20191209114404.22483-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209114404.22483-3-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Dec 2019 19:44:03 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> We've created a vendor directory for sprd, so move the board bindings to
> there.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (92%)
> 

Acked-by: Rob Herring <robh@kernel.org>
