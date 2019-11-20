Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEB31042D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfKTSGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 13:06:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45359 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfKTSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:06:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id r24so357405otk.12;
        Wed, 20 Nov 2019 10:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7pC2i2tAxNfTAMOIZsJuvMlE/NJ0sUDUFXuzIAgYHxg=;
        b=U/vlAipSTI3Cibc6cStajkpPYZ4qzOcELcQ3YSAXMGGZOcOT6xwRjVboRdQjE8CM1j
         V9Jc/EKlja+lt3KDwdnDC2wx4HBZE7JtCawCBKfGi3iujRY1yawSjXBb42SbiI+QGc6u
         8zyvMNDt0MRbl+HGEOJBS1LGa70/XAKze+nFQsbgOqAPrlVdAJoAmt85zQuy1tkMOIga
         Pl5gNt5acvB7eh66fP1aphvbTE0gSZN2WznZHLQy9m5XMyREiNIk8Y0m5rt3/64rVVW2
         A1l4pvElYnRqhACkFMG37exVOP4l+QV4Qy7vAH98ZDeNUn8MgGjByI/X+C2LusO9qoQz
         UlKw==
X-Gm-Message-State: APjAAAU6JXAgE9wR5wlq+UT8zxz6wrpUhhwkIQtRMKINLeDE1mz0WQxD
        pZciHfp4kTE8dSf8N4aafg==
X-Google-Smtp-Source: APXvYqwHgLayY+pckxZcjVrsUp91/dg86G7xrybugemvko/49GqQTNwFbiMki3EAXUomYvb0uqxa+w==
X-Received: by 2002:a05:6830:1f51:: with SMTP id u17mr3184832oth.318.1574273167847;
        Wed, 20 Nov 2019 10:06:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 41sm8654664otd.67.2019.11.20.10.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:06:07 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:06:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert stm32-exti
 to json-schema
Message-ID: <20191120180606.GA18754@bogus>
References: <20191115181239.549-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115181239.549-1-alexandre.torgue@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 19:12:39 +0100, Alexandre Torgue wrote:
> Convert the STM32 external interrupt controller (EXTI) binding to DT
> schema format using json-schema.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> ---
> 
> Changes since v1:
> 
> According to Rob's review:
> 
> -fix license
> -fix interrupts conditional declaration
> 
> regards
> Alex
> 

Applied, thanks.

Rob
