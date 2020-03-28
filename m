Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1501963E4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 07:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgC1GGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 02:06:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42101 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgC1GGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 02:06:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so14296888wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 23:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1YpAucpKgiwsoc4RW0hi71eNpwhZyorDjKoSzESyn5s=;
        b=aELxUY45UY6a2HgB3Gu9lZjc1ZKjXWZ0I9KmfTjF+I5sDAzeXDDNF7wUqCNDYry6w8
         th1J9PJ3J7k15x5nSY4JrETpO4aMgWM+QfXEft0b+CxpiHIAhT9K9FuWMEEx6KVynItl
         fJWWKeDh5ijhSfycEqfAN2vqaIw1jNo0TsZN8REBR8+P8MrVeoMLk5TeGKVl04c4uoId
         HVZvmQ0VP/L30j4X3H3zgph0TrzPFpX7btyaJLCn84zZBGhdMFjd3zesCG9qltClN1Xt
         gxcLqo6RPcz3H40fjNeA75Zd41l6yHhK8X7B481xZAT2on34l60In4MZiDvqIeIZN6xy
         RExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1YpAucpKgiwsoc4RW0hi71eNpwhZyorDjKoSzESyn5s=;
        b=N+tS/HIf/4qJZGiPVN9mU4FFxMwHeJDNfrHddINzuhxBHck177zQnIt3D25895Vz7U
         N4cdgpDsxjw02SBviL2KkNCR7oTbf47VuC91dKEluSs6e0+OOU0Mtq5tmEkVF8Kv3Mv/
         ZkjWCqla5bA5hXPaBcDeOYOzGPAcufKu5Cd3MFan4FbNyev9Hwtr9bQY96kpSqkjdnCx
         RPCT82deLZv5PkGbbcao/Lh/MJKfL7Kx2i1NSH3QMdzTXm+9720wBcWAH66AuOjDgRNp
         JNNJF1/0eB/ftWoYkZJZ8Mg67BNTn5tgY1A43GMUOs4cVflB21GGN9x0+UFIBhjjwm9B
         Ga8Q==
X-Gm-Message-State: ANhLgQ1lEpGLXoCavCeBCKmiQrriOw9ZC3V5fmIvXaX0Ir4bavBwmdmD
        GwOenQ04ZH5xeGwCgW2hgig=
X-Google-Smtp-Source: ADFU+vu6vjV33VVdjf+qxlHn4Yk1kuurtfoG+YBKbXsdJZ9JsxYuI9sHw4tUXbEobubzDBM/5HuH6A==
X-Received: by 2002:a5d:54cb:: with SMTP id x11mr3419049wrv.179.1585375569441;
        Fri, 27 Mar 2020 23:06:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i19sm11273194wmb.44.2020.03.27.23.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 23:06:08 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 0/3] Cleanup scan_swap_map_slots() a little
Date:   Sat, 28 Mar 2020 06:05:17 +0000
Message-Id: <20200328060520.31449-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function scan_swap_map_slots() is used to iterate swap_map[] array for an
available swap entry. While after several optimizations, e.g. for ssd case,
the logic of this function is a little not easy to catch.

This patch set tries to clean up the logic a little:

  * shows the ssd/non-ssd case is handled mutually exclusively
  * remove some unnecessary goto for ssd case

Wei Yang (3):
  mm/swapfile.c: offset is only used when there is more slots
  mm/swapfile.c: explicitly show ssd/non-ssd is handled mutually
    exclusive
  mm/swapfile.c: remove the unnecessary goto for SSD case

 mm/swapfile.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

-- 
2.23.0

