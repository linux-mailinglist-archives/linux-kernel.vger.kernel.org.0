Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC868DB26B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408129AbfJQQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 12:34:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46045 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbfJQQeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:34:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so2665891oib.12;
        Thu, 17 Oct 2019 09:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vb3NEiIkWc24DZr6uWoBxgdelPca9NnceF0V+QvAIKw=;
        b=i/fXgxgUFPvE7kHhydPJuhtaLi/83P/d1JqrFT4vpaTDdx8JrdCbiq4XTXqiNJ2/cN
         lXYGrgdyEfg6jGgLz+fsXFGdBaeK346j7viHL/S8TsSJIPr4TkY2523CoKs70s5/y/A9
         S9v3jFOxcxrM5l7Rjv+hLD2WCsYWdnPhqYUoy6v+CUpuwpBtDnWvpEp117zoY62B9Sia
         MBQkMde0r9RThLlc6RyqDMOQOs1+ZAhTZ94Z4qwmSrjZbJZVf0y8q3HzFd+0sJJdOQGx
         quu8c5OEGmxTdCbR+yOxxC6QbaacBt0jrMr2aFdMMmf2iPNbx2BIjsbqBsirS9DFjeXn
         beOQ==
X-Gm-Message-State: APjAAAXHstFfEkBLB3HIrDUhpueT4ZLKxnljFdXYAGpPZV/xgpFiadIb
        z8Q/H7ab4XnDqT7IqvsI9UuPEqs=
X-Google-Smtp-Source: APXvYqwYD3AVF2BEc4z/z1+7K+G6abfOyaOtFugvE8+kSzC7ebxIK8XRx1dysXuBGpnXjDYiPl/uow==
X-Received: by 2002:a54:468b:: with SMTP id k11mr4125215oic.174.1571330056063;
        Thu, 17 Oct 2019 09:34:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a21sm631814oia.27.2019.10.17.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 09:34:15 -0700 (PDT)
Date:   Thu, 17 Oct 2019 11:34:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH] libfdt: reduce the number of headers included from
 libfdt_env.h
Message-ID: <20191017163414.GA4205@bogus>
References: <20190617162123.24920-1-yamada.masahiro@socionext.com>
 <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
 <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
 <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 08:01:46PM +0900, Masahiro Yamada wrote:
> Hi Andrew,
> 
> Could you pick up this to akpm tree?
> https://lore.kernel.org/patchwork/patch/1089856/
> 
> I believe this is correct, and a good clean-up.
> 
> I pinged the DT maintainers, but they did not respond.

Sorry I missed this. Things outside my normal paths fall thru the 
cracks.

I'll apply it now.

Rob
