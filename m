Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4506B7CF01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfGaUpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 16:45:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45645 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfGaUpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:45:03 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so139322045ioc.12;
        Wed, 31 Jul 2019 13:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IEdWqU8ZGIKi58VBvQ5Df0TfD3yH+WqFvbBa6oi6JN0=;
        b=gdAuq6hRNwcct0UEJR+ICcB9NN+jqRF2oBu36RUAqT4AATP5BZg/xCA2bNnN3O+iVV
         MzhIu2ufLMsqij+ncXAdCH5zaeglYmHmyFgpVNQTw1Jj5X+Zp5km7nVHDgsgU7zuJDXb
         K0z4NidosR44/dSZkqd/ZibcwMdOP8xAhyyGX8PwrUK/TsUULa5zHlkicKQc3RyRNcbq
         Q9xFdKFBoBHi/10oTniWeE+fuseoPc1wPERl1HNBElyxXHgONKjRYX9I7CSgrFxqcWQ8
         ipDlZyHAhzq0WM+x77249XlqIlbVwEMeT5JGuCkCqbPFn5BU18maKyzVXMDeVuCDWKca
         0GTA==
X-Gm-Message-State: APjAAAUF4LhyX/TMNJyy6W8rrpbkCkufByVi483e89URsmCGcCOTCZXm
        hz5Pz3vIAlgunGnJHmcKNg==
X-Google-Smtp-Source: APXvYqwzwZZOidfJYrJYlhodKg0mYboN9I3Q0BeikYWx8dkhXD4Oe6fAGwkanR/mlCD2tlc0FX8G4Q==
X-Received: by 2002:a5d:9416:: with SMTP id v22mr45821355ion.4.1564605902112;
        Wed, 31 Jul 2019 13:45:02 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id t133sm102419600iof.21.2019.07.31.13.45.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 13:45:01 -0700 (PDT)
Date:   Wed, 31 Jul 2019 14:45:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] docs: writing-schema.md: convert from markdown to
 ReST
Message-ID: <20190731204500.GA6131@bogus>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <a239cd93ad86579ce7e02bc3032abd33b476e193.1564603513.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a239cd93ad86579ce7e02bc3032abd33b476e193.1564603513.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 05:08:49PM -0300, Mauro Carvalho Chehab wrote:
> The documentation standard is ReST and not markdown.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/writing-schema.md  | 130 -----------------
>  Documentation/devicetree/writing-schema.rst | 153 ++++++++++++++++++++
>  2 files changed, 153 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/writing-schema.md
>  create mode 100644 Documentation/devicetree/writing-schema.rst

Applied, thanks.

Rob
