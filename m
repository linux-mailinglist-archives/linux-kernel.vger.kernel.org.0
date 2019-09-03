Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6193FA71CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfICRie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:38:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46565 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICRid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:38:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so17071933wrt.13;
        Tue, 03 Sep 2019 10:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBqHilkfOcB2dgVFp2zrGg4KecQIKZaO1baj+V5ZLeA=;
        b=W1pshvHdsgFmg/NZ9Xs0GQF7DJjxaJrrZwRtDb14v0PKqfKgYxHy0HxiNg36ae3wjz
         0Y8v9VownQe5LkUZ+8NSmYshyxyOAUy8cNOXB9nZOTizqxxU+crsYOxGg+UoE2iHjLYH
         q4n+btdGCopB8HRvmjiUZqFJJbsWyuJA6E1RqsVDs433sgkgeLgmcT9/VzF5oRUIjWrW
         UlBn4t+GN+SlaKIDHL5i6ZUIsz3OUhfrLHaoOkXgNyh53aKNEmTViNwNl4w36gsOXdPj
         yej7jyZ3xWI5fIN9q3GwZsBGdn9TwDcm2DiOKlYOYqFowMcEuICaRm9oicwDwL6qohdQ
         d6QQ==
X-Gm-Message-State: APjAAAXejZqJgX0uuCp5JfltHcDWcUSTKfsTvNp58OrlOY2LVjdgrUNa
        bmrurE/hxPFpWRi4Ufg7EFk3jGPutA==
X-Google-Smtp-Source: APXvYqwuvQAdZs7UJic1n+k8xOo79s2Fmbyq5hoWrskhkVJpqSnUJ1lpChQWcIUhDdxOsJpTm6mxMA==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr43522126wrb.261.1567532312034;
        Tue, 03 Sep 2019 10:38:32 -0700 (PDT)
Received: from localhost ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id y13sm17111114wrg.8.2019.09.03.10.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:38:31 -0700 (PDT)
Date:   Tue, 3 Sep 2019 18:38:30 +0100
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Subject: Re: [PATCH 3/4] dt-bindings: arm: amlogic: add Amlogic AD401 bindings
Message-ID: <20190903173830.GA30743@bogus>
References: <1567493475-75451-1-git-send-email-jianxin.pan@amlogic.com>
 <1567493475-75451-4-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567493475-75451-4-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 02:51:14 -0400, Jianxin Pan wrote:
> Add the compatible for the Amlogic A1 Based AD401 board.
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
