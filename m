Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00F132012
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 19:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfFARVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 13:21:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35097 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFARVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:21:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so12560476ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tccTfkPaCkJqRCXrpmp0F9b3WbVNC0IPQMXCiDJx7Zw=;
        b=UZtlyyL6Ejbc3chPwsjMtIJrr+PXyz7LxaO4UIZFJt2+uxLH5ykzqraVFcICHhrsY9
         pGfOa7MQ2C6zVn3ddiQXwce6RVhQcO8AvhM3d3OmVGP9AlXxqoOqMNQtxdd+fsYhSoZ3
         6mdjty69zdNWY2S+vzaOoG3QQSTu3k9QJSCFac1JleRtSBsrOUd+FLpqegh+BbUlPfG2
         Ih1/6yKSKGQVyfe/wYgbkqaXy7OEU0wvX176nvmmPqyDNm/VH5RLolti/OKrXLhwTs5D
         U5ApdQK/AFDljwY6mE/ZUvu9SXcqTwmt1oX4FzuSMHFmNkx9doAwynnQDftnnTzwdz2t
         T8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tccTfkPaCkJqRCXrpmp0F9b3WbVNC0IPQMXCiDJx7Zw=;
        b=INzEL3aVPUZFjioq8K0JSkk2Z2WgO1xon26QsiuehoW5ZWsPD6EBhiYNMbKldOufw0
         Xlr+d/s2DyN4yN7jQpAcUTAM87RG/DOnWYTsumL1sDJkUaa4+BZWI0OZKIhvOMnBeFUb
         l8kV1LJ1s9GC7ASfIrTWmOreQ6x/VelaN0XBrgeu5mvglIDDuvOPFPYoyNyAJEKlHya+
         aCnwhwZdaa5bOrdaPtPGJ1dMxD6ChXFh0atzwgZ6PN+y4Mrq5r5UhdYWJsmrNi+ljG0s
         uTutu/YnR5CgziToRXxlJcJ9C0pXSrfdp5+jOoQOg5p9Mctekjxaiv7hkIB/c/nNl8n+
         vT7w==
X-Gm-Message-State: APjAAAVYSjbc8N+6DC8uIOHk4iD0275efsXf1DAnkBIxLKz8z20uP2+m
        +pSQITiZzWO50pZ2R7HDdjnaa1fclPJ7Qx0TqRbGuw==
X-Google-Smtp-Source: APXvYqy7Mf/XaWFq/LXOzPSf1s6Jcjn+sKV/HBkrnZUpN8ofis3WnAWx2KOtRgDlC08AA+7Y/pJ1KFcI15Rf9GhIu2A=
X-Received: by 2002:a2e:9018:: with SMTP id h24mr2415646ljg.165.1559409701490;
 Sat, 01 Jun 2019 10:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <1558007594-14824-1-git-send-email-kyarlagadda@nvidia.com>
In-Reply-To: <1558007594-14824-1-git-send-email-kyarlagadda@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:21:30 +0200
Message-ID: <CACRpkdYMx9obZV70EsieU_3eVVxqu9jVFpCO3Fk4t-2PUya97Q@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] dt-binding: Tegra194 pinctrl support
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>, vidyas@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 1:53 PM Krishna Yarlagadda
<kyarlagadda@nvidia.com> wrote:

> Add binding doc for Tegra 194 pinctrl driver
>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
> Changes in V3:
> remove optional fields not supported by pins published here

Patch applied with the tags.

Yours,
Linus Walleij
