Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F40E15A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403780AbfJWJVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 05:21:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43506 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403757AbfJWJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:21:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id q24so9215343edr.10;
        Wed, 23 Oct 2019 02:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RR8CC8SQ8Dt9vU2p+011hdqVQSDGaSdoOwPBwDXuWag=;
        b=Ll4N4XtDP4JpSj2M02FePNghQcFL9Cmf0OqSqmghmzOKF8i2xSfNgTFwiGUxeoX7A3
         6Ym9nn4tR0mUUItPivyq6jEblhKs2w9QhFLKzsygjChMQ5BcHnJVGcDnKCHqXMwDcpBg
         mUTTnBOX9I6m/HwMWkOjO8Xky+QQCRzp1L8PyMK7zmPLbnTLFGIgAGMTWdoA4XE5+NP+
         4Sj/3i70RcBLT/UgrcUqcVLHhxl9tUwFJFWUN27msTIuE+L05wXtyKgMbOsUtOB+FmSI
         Bs5lBUwi4s0t8c9dDDl0Wzk1x4GGuLQYfaLQY8XfWT2UTC5yu0i+GZ5tx+TMSy1IFlPD
         /A/Q==
X-Gm-Message-State: APjAAAVrPZy94t8TWrdU23RkpZvWGnXHeXxXF6VUy79udb0LhlcLp1Vl
        jfI1Rs9b6wheauiNvJAnBTg=
X-Google-Smtp-Source: APXvYqxuVcaV+VBzNpgps2gFjmkQkSUYEY/wz9MqeGbZAanEIxv8UUUdlRAUYHNvjy6Ht6iiwKFRMA==
X-Received: by 2002:a17:906:76c9:: with SMTP id q9mr31542254ejn.53.1571822469791;
        Wed, 23 Oct 2019 02:21:09 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id o22sm739665edv.26.2019.10.23.02.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:21:08 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:21:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: max77693: fix missing curly brace
Message-ID: <20191023092106.GB10247@pi3>
References: <20191023080427.GA18784@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191023080427.GA18784@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:04:27AM +0300, Matti Vaittinen wrote:
> Add missing curly brace to charger node example.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Resending as I forgot to add the LKML in first attempt. Sorry peeps.

LKML is nice as it agregates all patches but more important is the list
specific to the subsystem:
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)

(+Cc)

You also keep cc-ing wrong email at localhost.

For the patch itself:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
