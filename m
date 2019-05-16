Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6C20FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfEPUnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 16:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfEPUnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 16:43:43 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F7C420818;
        Thu, 16 May 2019 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558039422;
        bh=gLQlhu/nIee7VpLHO+jNzMX7EzEWYbRmsgoyaEQ2kvk=;
        h=From:Date:Subject:To:Cc:From;
        b=pLxNwrntTX7oaMn2J6/MDoK1Lmlw9T4zTvWmXWCXNlXV8W7etSl1vym+9tcr+/1Bg
         WiaBKrVGmgAhxtMwfIFF3wieKSaHjL3yWYo93U6sqlzUXcOAY7co7f1RwbWI28+EjG
         3dUB7rAwyWjTSdVcEhh6kb6X7A1Mm+WV3J7xkVjo=
Received: by mail-qt1-f178.google.com with SMTP id h1so5647865qtp.1;
        Thu, 16 May 2019 13:43:42 -0700 (PDT)
X-Gm-Message-State: APjAAAVKkLyd6gBOD/PnTKSefOUEOZ0Jh5zg7ZqBs8xE/XhWX+hb51IW
        buPtDNae6w0Qnu87U4IoJ7oJJSvNkLNSP3Whdg==
X-Google-Smtp-Source: APXvYqzuh0y5kOj/3go4aciCPP+1J/ri1ee1q4XSUHZQTrZLsJwcpD8HswNMNZPnAz50cBqLuoTLDXy07fuhNm+zcXc=
X-Received: by 2002:aed:2471:: with SMTP id s46mr44714316qtc.144.1558039421577;
 Thu, 16 May 2019 13:43:41 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 May 2019 15:43:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLtkGfSX5bdRWy7MXM+opAd-gWzhTorUoVXOpKktN8YKQ@mail.gmail.com>
Message-ID: <CAL_JsqLtkGfSX5bdRWy7MXM+opAd-gWzhTorUoVXOpKktN8YKQ@mail.gmail.com>
Subject: [GIT PULL] Devicetree vendor prefix schema for 5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull this 1 additional commit for rc1. This had to wait for all
the merge window changes to vendor-prefixes.txt to go in to regenerate
it.

Rob


The following changes since commit 01be377c62210a8d8fef35be906f9349591bb7cd:

  Merge tag 'media/v5.2-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
(2019-05-16 11:57:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-for-5.2-part2

for you to fetch changes up to 8122de54602e30f0a73228ab6459a3654e652b92:

  dt-bindings: Convert vendor prefixes to json-schema (2019-05-16
15:27:21 -0500)

----------------------------------------------------------------
Conversion of vendor-prefixes.txt to json-schema

----------------------------------------------------------------
Rob Herring (1):
      dt-bindings: Convert vendor prefixes to json-schema

 .../devicetree/bindings/vendor-prefixes.txt        | 476 ----------
 .../devicetree/bindings/vendor-prefixes.yaml       | 977 +++++++++++++++++++++
 2 files changed, 977 insertions(+), 476 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/vendor-prefixes.txt
 create mode 100644 Documentation/devicetree/bindings/vendor-prefixes.yaml
