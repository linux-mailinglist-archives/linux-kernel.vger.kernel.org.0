Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4255C2D07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 07:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfJAFzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 01:55:01 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:35671 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAFzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 01:55:01 -0400
Received: by mail-ed1-f51.google.com with SMTP id v8so10756682eds.2;
        Mon, 30 Sep 2019 22:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7eOUI86iG6zJ4Z27pcKDmq/jop2P47fuZYQblHLb7ws=;
        b=dvpx6VZBtOxAA+f+EcqZhqAA4QhzLtHL96B6j2lCcVrlTYdNjY+7pUd4Qk7Z16cJ+7
         oFXSbipwGXX/uueSDJCwJtH85erRMzxcd+m6W4Nupunh9LePSFPo+8MWgxLTnd2m63rt
         40Ej3F5i5o9CGUuLVQDnzhCOCmIQ+F9F96rW2wKZkQS6ha4zHuaItVsWl16bdfwD5wNv
         xOMvIn/CcQcZfozNUONW7m/oaH3/GNfDnUGyOcnaL0jKzgnXif/VHRaFDga7cADP8bqX
         u7yoemPiFjo+LLl3wU42n2q/+WrtbbRc/wvphg8k8npXVANU9HXsma5ptBk5Cf/ebEUt
         PROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7eOUI86iG6zJ4Z27pcKDmq/jop2P47fuZYQblHLb7ws=;
        b=JLmhAe9u8Sq+3TmPHzfILIF00SubzCMy/YHXM1nHeddArT0IuEsqgubei0sj7xRRlv
         qRAyWNxN34BtAotXJ811lkMdKkWhtDhvoqp4vxtJw6ndsELmKKVdaEWCnnPPajxaxdDP
         X979S+5IB60IPq5bwaIGZiWBGjPWGBgiOlR+rL+g8RyBjefUS3dLrkZ0AD2OrCsrkMmD
         VxeIdmaGdDHW2HUTWkCsFGD2lGZV7FL2F9pHp0ozPGBsWfSCsSO5SyoBkn48r6UP6dpK
         eheOFLeIOgw70TLP+v7x+mW7YxFHoDrKAIqK4ZTPS89XsrQ7xoHbT70/vB/bFV94nbEB
         Hmsg==
X-Gm-Message-State: APjAAAVXNT9/wZtGgfcMpcjuGcBGGKYUL0ZtmoHeQQ7Wg1AOfJQxZ3CY
        vvyOs8MRwqVa9SmXB+ZKSPVuNHsR1EtVbqeE5ikX5/F4
X-Google-Smtp-Source: APXvYqzcmpeAUYQ4KNZfxLTzxMNkT9ZglOxVQ7XcAmMxFkZh7muLBaL1xHCfrmkr50MA7803Zz8nsBdEogdG7DzSxJI=
X-Received: by 2002:a50:ed17:: with SMTP id j23mr23337902eds.248.1569909298460;
 Mon, 30 Sep 2019 22:54:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:cfc8:0:0:0:0:0 with HTTP; Mon, 30 Sep 2019 22:54:57
 -0700 (PDT)
From:   Jari Ruusu <jari.ruusu@gmail.com>
Date:   Tue, 1 Oct 2019 08:54:57 +0300
Message-ID: <CACMCwJJz+3w-MhZqHgbr0QVXQpvN9+xuXZoLPgrMwgNcWVXNhw@mail.gmail.com>
Subject: Announce loop-AES-v3.7p file/swap crypto package
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Worked around kernel interface changes on 5.3 kernels
- Worked around kernel interface changes on RHEL8 / CentOS8 4.18 kernels

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7p.tar.bz2
    md5sum a8e8f2c3fe27b67f332c33555b9d8c8e

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7p.tar.bz2.sign

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
