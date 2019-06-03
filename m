Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38F833B39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 00:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFCW3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 18:29:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39208 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCW3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:29:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id a10so14544214ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plB+0yc0ip4AMYAM0GIJuNCdbr5+mAuBnyJ3DTHcuxw=;
        b=vMhCvc5eyn6iXsQBFthHqsIE7KKBreLhSg98Niv7pKdrCZhzVGZGxFv6i1SFR1nWPh
         SGg1uA1nPALEXtKbQS0OinPliW+OTPuesLpBphxSx6fgwe/uUZHX2ae/lpEv2KOpo1HH
         Y5tXOUGXz6ntnvkDAwahbchvRKps2hu2d8HMVPO6FM0dLB1xg0KZvTDG8CSUsoKrdmzs
         OFOYp7T8v+3TdFAeaI83SxYuZQzs5KUL8s2efrkL9ISscha58EDDBE7fz7iNHc6wccHW
         R7zJkFWGfQxUJRW0Ibw1Yw52jl6z2++SvAt63RjJfi//XepzGumhysUtnMx+upajWlCB
         2+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plB+0yc0ip4AMYAM0GIJuNCdbr5+mAuBnyJ3DTHcuxw=;
        b=FoOUdtjBVVfNPC4ZUjIJDJJa5fu3vwD6UKnfQj3h9opoRXK1DZnOFfNCGac5ddLrMB
         P5bwBT/95lMik0HwiyHZW8bysoeuxBoqrV4gcZxliXgRy0MfVXtfPtQVTzWKUEMepeyi
         zCHo5kLUOUbSD94XzsOM0LM0RlhZ5xYnP+fowWA/KVrmLp1e7O+ytMIx13lFAJf0Xklm
         XxJTXeMS/PLnROt1J+m13OoqZu9amPMHTmK2eK6pQm8MRXqbMbYSPI/UWmWlqvsXP9o4
         H/91AvCWXUk3OPuajUTaAEsOQgXX73xjjz3kELrh4vuuptrmDC4ecRm0bBVPLOw81NJh
         RsGg==
X-Gm-Message-State: APjAAAVIHgUFTvNyLYhc3hnleEv+H4UiOUBCm/PcrKrX/OhjR+wY9caO
        RS3Aj2FlzUBP0MKQ+xgSz2C2oQ==
X-Google-Smtp-Source: APXvYqwrvesoOhScXD4D/ySVRVl7oOgY45yO9rbfO0Mhp38j9TQypwrzRSWWhQ1fSp2PL6ew1JrxzQ==
X-Received: by 2002:a2e:2f13:: with SMTP id v19mr6633612ljv.203.1559600959964;
        Mon, 03 Jun 2019 15:29:19 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x20sm2175874ljj.14.2019.06.03.15.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:29:18 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: kpc2000: various minor checkpatch fixes
Date:   Tue,  4 Jun 2019 00:29:09 +0200
Message-Id: <20190603222916.20698-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a bunch of checkpatch fixes for core.c in staging/kpc2000.

Some of these were sent earlier but not applied. Now rebased on top of
staging-testing (incl. Jeremy's kpc2000 misc device removal commits).


- Simon

Simon Sandström (7):
  staging: kpc2000: simplify comparisons to NULL in core.c
  staging: kpc2000: remove unnecessary parentheses in core.c
  staging: kpc2000: remove unnecessary oom message in core.c
  staging: kpc2000: use __func__ in debug messages in core.c
  staging: kpc2000: remove unnecessary include in core.c
  staging: kpc2000: use sizeof(var) in kzalloc call
  staging: kpc2000: fix incorrect code comment in core.c

 drivers/staging/kpc2000/kpc2000/core.c | 36 ++++++++++++--------------
 1 file changed, 16 insertions(+), 20 deletions(-)

-- 
2.20.1

