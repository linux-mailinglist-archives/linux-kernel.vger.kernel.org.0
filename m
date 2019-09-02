Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB4A5815
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfIBNjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:39:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35571 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731239AbfIBNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id n10so3981882wmj.0;
        Mon, 02 Sep 2019 06:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=Ljep6bH+jK/y7KzX9TmuYtR3XGnID6enl5X5Nz5+kmY=;
        b=GVzAvmAbOjGGF4G+c5qGrPM0uyOCiSoDdORURgDzXmMRl+Yo8hXORWc1tLuwx3zp2v
         dp7MMCU9iE0gqCXpakDGA6rDtoM1nRVv8dqf9zyB0PLTZTaX0Ygl2iviQQVv6MtCYyx8
         CpvCSjZwuV6jF0gW6oQkW4+SOHPUKEiuYlDKBNecAI8kY/1jTiXzmefmTRHfBpJvN5lE
         4VWePX/IWAHAXFxcMA8AIdHBeyZXVbQoUXJTw2fZQ4ekrpD8QITSh3zZpVoiqXHldehz
         wly3Ep4klV28tGfAW5eoryeMVZ4KXSsYhoUOu3FS5kBhIyCFPiQIya5AdXom4v/JHh1a
         WR6A==
X-Gm-Message-State: APjAAAX93R8k+igXzciCbQGJpGBZcZxjDwrK/EjJDe8nTIvKWKq8o/h3
        2F8lBq0Gak0QucoDu9iP5NzbtdF9pQ==
X-Google-Smtp-Source: APXvYqxpPvpnT9a93gVp+b7ar8pc3AEKNSZ5yS0Q62pduvGJgd3oF79YWeSiKcS4TSsXPrd6GYW4Nw==
X-Received: by 2002:a7b:c091:: with SMTP id r17mr33360948wmh.74.1567431549560;
        Mon, 02 Sep 2019 06:39:09 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id m18sm5952612wrg.97.2019.09.02.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:08 -0700 (PDT)
Message-ID: <5d6d1b7c.1c69fb81.7f479.9ca6@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:08 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: Document ibm,cffps2 compatible string
References: <1567192263-15065-1-git-send-email-eajames@linux.ibm.com> <1567192263-15065-2-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1567192263-15065-2-git-send-email-eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, andrew@aj.id.au,
        joel@jms.id.au, mark.rutland@arm.com, robh+dt@kernel.org,
        jdelvare@suse.com, Eddie James <eajames@linux.ibm.com>
To:     Eddie James <eajames@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 14:11:01 -0500, Eddie James wrote:
> Document the compatible string for version 2 of the IBM CFFPS PSU.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

