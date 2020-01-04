Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3F1304A3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgADVZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 16:25:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36073 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgADVZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:25:17 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so1311851iog.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+QRNOYzxwByERqG97+Z/p4ZedPlWZDV5EHbZiPaR+4=;
        b=OQ82mluhYroVd4OAZdcJHNtTAmVn6/pAH72TRUNVCa1T9vXcxE4hG8AkTHV9qv6Tc+
         2Ry5fZtpkj2GtGXPkBDxuPIyhN567BWwamlGMwiJb+cnH0Ct93bAI62xNQwVkozEadZw
         vY72MHURDCUiuyh/J2A4CwUtAH5ezHldiRRWcL/1tzUbnJs9E/0vin+/es9WiAZglrTk
         QfM54nypyg7KeT5p2/sAGJCavH5+MxQgcpspht4J5MeHm35+PqTYeo7b4L3UwIpgqSV5
         xOvnM49mQt91k2KNWUp3ElCcdNHDcSeHm5z1n/l1y58GHTPHv+oiH5zBwUJW9EMMwbLW
         4f7A==
X-Gm-Message-State: APjAAAXqPPxJKpsKW8nE2iY2+Qk3WheYiG9RRrQUn7snGz0FmYuUNDS5
        EsnX69ehPQ5Kr06kK7UmqwSPDpA=
X-Google-Smtp-Source: APXvYqxJ8b7sOcBRrcziHx9aCWkCQrMpomUB2LqsfHVVHsciD4aU9C4HdQvteSLxIG++Rp4hMZl04g==
X-Received: by 2002:a5d:8b96:: with SMTP id p22mr61888821iol.93.1578173116759;
        Sat, 04 Jan 2020 13:25:16 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q65sm22333186ill.0.2020.01.04.13.25.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:25:16 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:25:15 -0700
Date:   Sat, 4 Jan 2020 14:25:15 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime@cerno.tech, jsarha@ti.com, tomi.valkeinen@ti.com,
        praneeth@ti.com, mparab@cadence.com, sjakhade@cadence.com,
        yamonkar@cadence.com
Subject: Re: [PATCH v2 07/14] dt-bindings: phy: phy-cadence-torrent: Add
 clock bindings
Message-ID: <20200104212515.GA11395@bogus>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
 <1577114139-14984-8-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577114139-14984-8-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019 16:15:32 +0100, Yuti Amonkar wrote:
> Add Torrent PHY reference clock bindings.This will not affect ABI as
> the driver has never been functional, and therefore do not exist in
> any active use case
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-torrent.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
