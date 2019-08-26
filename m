Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1579D270
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfHZPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 11:16:50 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39472 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfHZPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:16:50 -0400
Received: by mail-wm1-f52.google.com with SMTP id i63so16248206wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igsbCYOKQPXuz2jqgHCFB6ct4mrUckiUDgsHpkYxaug=;
        b=e3SMmeaFDX+31SNx+EcNd75GyEWM3ZttARmISqefRyDzwT8lrGIeVg+7VB1xRXUqqX
         kVAJ7G7mw/umgX1OUSYXsJPs8EnbkP/YVE/yn/YttFwTn/PERYhhM+FCWLzfXV9w2CDh
         ZdtYB402fHu0uQAw0v35Ft3UUJn5Zl4Nya1eZCfckM4nEpwK6ZmOe/D61NhVwjvi+W3x
         TwbOFPQ3xhKRdjfVV+VJ/YHeJ7cb6dnZvpeDFU3OWuyLSNjfs32l6A2H8zOIR1uMQ+JJ
         +SqNSyBBsG4Q4rsWulvHx8HRfn9RBx5wyUdiZ6esSz+DNvuD2DSarMT5JHWdQF6qIJp6
         GOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igsbCYOKQPXuz2jqgHCFB6ct4mrUckiUDgsHpkYxaug=;
        b=n8jpjkhhOgIuvs2laPvaVNHTQebE324e5VU2Dmn5MQV5l/iQ9G0XlEZZ2k2E5pmtUy
         dVjNLIvzAVRn8LnrQkm+QEq8rUyMIdt78+tKXhCvmmM2eBf88ZLF+FqWvuEBRUGukag2
         5h0TjBa5Qjsq6mTwmR5Je6sDGIx0rhVvPpv05PW2nFXB/Lx/sitdfvF/WuLQSSneBKQe
         V7ESr49c3dgB5SP1ZazqrvKxsPzc7dCIFWzdP4LlwD6IRwDZYyQrV95r8Q7A58EElQJM
         yuh/7ZlZziTt8+XvKm1S8iLKrDWTwT0REM7EmKalyiRXGMiRyx+ADjpOjGRMxvnOzJQR
         dcRg==
X-Gm-Message-State: APjAAAUWUU5xhD3ir+FX1U5Fya+UB+ejmzhEjXSLZs194PvCZLtOU+nV
        sUB7vAplFJExZ9UHuFvbPqfiCg==
X-Google-Smtp-Source: APXvYqwmXVmdc4R/A9KVIpeXYWuCOT43Q+g0RJ1Q8wsu7sWtXT9UZSRttvEBXAA0vmWalOah6sVkfg==
X-Received: by 2002:a1c:a909:: with SMTP id s9mr22321779wme.20.1566832607764;
        Mon, 26 Aug 2019 08:16:47 -0700 (PDT)
Received: from localhost ([2a01:4b00:80c6:1000:5b16:35e9:1ce5:7fc9])
        by smtp.gmail.com with ESMTPSA id f23sm13385748wmj.37.2019.08.26.08.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:16:47 -0700 (PDT)
From:   =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: cdrom: debug info changes, Beurer glucometer support
Date:   Mon, 26 Aug 2019 16:16:36 +0100
Message-Id: <20190826151640.5036-1-flameeyes@flameeyes.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been hacking around the cdrom driver so that I could get Linux to
mount and access the virtual CD device used by the Beurer GL50 evo
glucometer. The device is fairly quirky and goes into a reset cycle on a
vanilla kernel.

Since I had no idea how to get to the right changes at first, I ended up
playing with the debug information a fair amount at first, and I thought it
would be nice to clean it up to modern standard. Joe Perches suggested
removing debug output redundant with ftrace (which was actually quite
useful to find the right places to change.)

HTH!


