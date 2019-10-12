Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F468D4B68
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 02:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfJLAh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 20:37:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46881 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJLAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:37:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id d1so11391386ljl.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4Ki0HjVKaflfmxJ2byTawmZD59wBPdISnRBsFf1+EE=;
        b=GwdKcecDHoPtTKefPJDFPiTifnR2o2DiQsdu9eYxjZKHNGVh4M3eyOGTtSM4dIBG9w
         2RD8MYbieejLw0IVF+lNSxv0IoF0Tg5WlyczNlhvVquO1YUWfqC+lsZsa+DTKHu9ThbS
         t+PHqCQqQFlR0W2nZ4ZSIuYfyJmz7hREKLdbJEofiuaDJXYcxJNbydcD0h0c8WqVUJl9
         493ZoqzSV/+idkqjGDTon1NwD63dr4FCuieLRUOIjNQXWGJjMIBC2EOAfdD4LJ2YPLKp
         DXao1EjYBaRXqpKvw2MFhPr5LpYkb+twKkkUXKum9dBP/sPfT68zeszbwuqWLzIRsIQE
         MQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4Ki0HjVKaflfmxJ2byTawmZD59wBPdISnRBsFf1+EE=;
        b=cZrZqU9vePX6/OU+9bMsvtkFY5QRXZdsqFHgHc5uT5VXWUa9huzcwP5TJlMT6sAfq/
         7igEovJXK9spZBNrsXivFgCtxQEWw6F4g4YolLqAy5iYGUinVqA4CHDloR0xeVh9jNuV
         Uq9sW2aaUz2a0rcu/OqzslQgVY2/ufWco1j1mZl5mgvEHOlD6zriGXDg4l+zStp/xug7
         oH9PnaWawXK57g4OWu0nIGCflPz9NPKpAnDsJkq8H94CwTvpWNQGiAy6vXmv+NLcahSq
         NgNfz2lUmTO4qrrYePQf0OArQTzx+REhvbHMT6VmhGo6+8QSu+4KWm4GDnAAuouEadhL
         r8Lg==
X-Gm-Message-State: APjAAAURSMpatZvWOesYtm5DZ9iYwMTxPr7hHOkCUmpmRjwBFGH2ZvMe
        UopsgWxHsyX4TIpW19sHoyg=
X-Google-Smtp-Source: APXvYqytgLNEilHpnDPZTz37dMIPamPyEfsAHb42Fyj4zkTggkCK5P5YAx4Af6P5wT6BgrshuxohoQ==
X-Received: by 2002:a2e:858d:: with SMTP id b13mr9538774lji.71.1570840646279;
        Fri, 11 Oct 2019 17:37:26 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id f22sm2346620lfa.41.2019.10.11.17.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:37:25 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 0/4] xtensa: fix {get,put}_user() for 64bit values
Date:   Fri, 11 Oct 2019 17:37:04 -0700
Message-Id: <20191012003708.22182-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series fixes return value, out-of-bound stack access and value
truncation in xtensa implementation of {get,put}_user() for 64bit
values. It also cleans up naming of assembly parameters in
__{get,put}_user_asm and __check_align_{1,2,4}.

Changes v1->v2:
- initialize result when access_ok check fails in __get_user_check
- initialize result in __get_user_asm for unaligned access

Al Viro (1):
  xtensa: fix {get,put}_user() for 64bit values

Max Filippov (3):
  xtensa: clean up assembly arguments in uaccess macros
  xtensa: fix type conversion in __get_user_[no]check
  xtensa: initialize result in __get_user_asm for unaligned access

 arch/xtensa/include/asm/uaccess.h | 105 +++++++++++++++++-------------
 1 file changed, 60 insertions(+), 45 deletions(-)

-- 
2.20.1

