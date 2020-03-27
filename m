Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A159195927
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgC0Oh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 10:37:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44301 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC0Oh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:37:59 -0400
Received: by mail-io1-f66.google.com with SMTP id v3so9930782iot.11;
        Fri, 27 Mar 2020 07:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1CIjqCN7HIBs0BbXhXphBz3HFYsacVCZkjeYXY7tAQ8=;
        b=QEmJPECrPLvxmbcmKgRtPI4f3j8ZIhcXVB7MSXdliskwpM/Hrnb8vvulLn31f2zEF4
         jGIDNQ4XMQJEWV0Si1V+wi7yHbQBRX5Vr19twXptgTlMXT8IuL8sNHNYVQVwoFQ/VQsr
         3QeQfsx6VZIJ5ezZu2pV7D3WNYwlxWcYFXlOh6jKT7jZs58EhqiwXyCfp5yJrClVW4dN
         SE15a171BjwQv55QLgMQ0Saqm+XCSw+aN6HF145EMXh4od09C7FkTWX8it4MeyEociqg
         GIwsVXkUUaE1Hrtlxz6haBlHruCUWRabAwtNGxh8dirfVtsw/BVdbjhE+8vbp2x50wjs
         MX9w==
X-Gm-Message-State: ANhLgQ2NaEDoCc0fOpryF5XBeeNv3i9VkJ53g1SEQk1H6QeCh+eCogbx
        V4wZUI0z7Eb9+7oPN923wA==
X-Google-Smtp-Source: ADFU+vvJVZDwyQMXr/8tZh9UhxFlUIkgx3KfbLBcK3Qb/x9wgIny9VMoKwrkyckBwlZsNZHoCIHvuA==
X-Received: by 2002:a6b:8bd2:: with SMTP id n201mr13155014iod.159.1585319878328;
        Fri, 27 Mar 2020 07:37:58 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z13sm1552390ioh.16.2020.03.27.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 07:37:57 -0700 (PDT)
Received: (nullmailer pid 3380 invoked by uid 1000);
        Fri, 27 Mar 2020 14:37:56 -0000
Date:   Fri, 27 Mar 2020 08:37:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fix for v5.6, take 4
Message-ID: <20200327143756.GA32333@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull this single fix for compiling dtc with GCC 10.

Rob

The following changes since commit d2334a91a3b01dce4f290b4536fcfa4b9e923a3d:

  dt-bindings: arm: Fixup the DT bindings for hierarchical PSCI states (2020-03-06 12:12:21 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.6-4

for you to fetch changes up to e33a814e772cdc36436c8c188d8c42d019fda639:

  scripts/dtc: Remove redundant YYLOC global declaration (2020-03-27 08:31:13 -0600)

----------------------------------------------------------------
Devicetree fix for 5.6, take 4:

A single fix for building dtc with GCC 10.

----------------------------------------------------------------
Dirk Mueller (1):
      scripts/dtc: Remove redundant YYLOC global declaration

 scripts/dtc/dtc-lexer.l | 1 -
 1 file changed, 1 deletion(-)
