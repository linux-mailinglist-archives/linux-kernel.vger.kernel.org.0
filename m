Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339C51925DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 11:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCYKit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 06:38:49 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33375 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCYKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:38:49 -0400
Received: by mail-ed1-f49.google.com with SMTP id z65so1747529ede.0;
        Wed, 25 Mar 2020 03:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rChnKt/buGlg4oMgDuHolFkSTfOBDmB/aUQmKVJ+Bu8=;
        b=HhzmmvPuo5WJNnfepT5Eqp4epSpOdFhdzED5w1oFTf0ml4B6wMvxyaaTFCjlQCKq2Y
         1O1iXBJvBTMtdrp6WvI3UFDr2Y0k3VJ3EO7tcipi6Uw/MFkM3+gxf0i74927eNksgYZW
         ljm+esdiul2QmTNABfQhrsijs5kZ95J5n+5RGbq+Dw1wjwPChmZE57ZwpR58xMcaeT9r
         QQp4F4b4FjR14709P6C4ep0HaWcalAZWpO+qAgBvRAG9sMcJXxzmEi2l/0IODn6IAUrq
         FSYRpIqVHeJaEmehDzmzz+pzJRK9HWnJYsbCLYE3lr5VTT85EdYnTxzgp2oSzQ93Lwun
         TzOw==
X-Gm-Message-State: ANhLgQ01Vk8lmGZR0mROPMGnqBqe+ZSu+zS8VdxOuvYP7bxTPF5AhiH/
        UfWKO2W89JWZuAt928KdQbs=
X-Google-Smtp-Source: ADFU+vu6wOHo0Oo5RedHizV/zMZxQCP2qEaIJff3a9ZAD1Wu4ZYA7zr+gdDKh5A2BskBFG1jRYSWGw==
X-Received: by 2002:aa7:c610:: with SMTP id h16mr2228662edq.348.1585132727057;
        Wed, 25 Mar 2020 03:38:47 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id s7sm1458659edr.15.2020.03.25.03.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Mar 2020 03:38:46 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:38:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/3] ARM: exynos: Pull for v5.7
Message-ID: <20200325103843.GA17099@kozik-lap>
References: <20200316175652.5604-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316175652.5604-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:56:49PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> One patch for drivers at the end of these series. I also sent a fixes patch separately.
> 
> As you asked, I updated the Google Docs with Exynos entries.

Hi Arnd and Olof,

Any comments on this pull request?

Best regards,
Krzysztof

