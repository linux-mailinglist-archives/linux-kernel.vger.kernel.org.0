Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49A5139C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 23:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgAMWdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 17:33:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35992 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgAMWct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:32:49 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so9954038oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8OSe8nCMD8zFTJxmKCShhLga5sECo0uXyDP7h9INGG4=;
        b=V152pUneh6bpZfLuJTAKo8HUA57Ur3x1TLHyZsxyIXnqyQDsdUN1D6hJaTuPkHpdWQ
         d2M/DY0PqdK7qKNvhs9fs4r5coooVPY6Sayy5CLlIQf7yZbtMBHjaigvw+btXNk8VTlW
         ZZQYsk+q2Hn4Ic5+RpmiNk/ApY/uLYm+9yHrIZICAVADeIKD1JAywFr//fvu56cFDd/2
         p+hKjXgD/nlY3jH9QO7kB9x73PFkYvXFCWJPQ5gEx5XWia//RTj4XKkp8JAnX8aZ8CJz
         qqc0qvbBxS4pUFVcqGW+CtDjQ+TyjWCK5/cL3a3VELEBS8/T/E7FAa0XRaMgeftcsPSa
         izAg==
X-Gm-Message-State: APjAAAUkYjVY6uPukt++mysDOLZL4KdIB2EcHCEElTZc/KUJsLOORxkV
        5sHMRcq3eUwdG2FJbYixi6Tbvig=
X-Google-Smtp-Source: APXvYqy2AhNDCBlrks/I5FYCK6wL1qxoCmgPt9wDTx13g2sBimdp2qVBa/vrCN5pv7clnImKTV221w==
X-Received: by 2002:a05:6808:181:: with SMTP id w1mr14929528oic.176.1578954768313;
        Mon, 13 Jan 2020 14:32:48 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d7sm3969420oic.46.2020.01.13.14.32.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:32:47 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d1
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:32:46 -0600
Date:   Mon, 13 Jan 2020 16:32:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: adv748x: add information about serial
 audio  interface (I2S/TDM)
Message-ID: <20200113223246.GA22019@bogus>
References: <cover.1578924232.git.alexander.riesen@cetitec.com>
 <20200113141550.GH3606@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113141550.GH3606@pflmari>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 15:15:50 +0100, Alex Riesen wrote:
> As the driver has some support for the audio interface of the device,
> the bindings file should mention it.
> 
> Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
> ---
>  .../devicetree/bindings/media/i2c/adv748x.txt       | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
