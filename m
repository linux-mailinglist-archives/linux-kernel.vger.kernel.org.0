Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F468E937E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfJ2XWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 19:22:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42470 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2XWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:22:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so611550qts.9;
        Tue, 29 Oct 2019 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RIHrM2T5t2yjqxj2JPTS71DBT+0RqAHHijTzNDzZvQ=;
        b=oVu5mhpbwaYDhSZVWLJHva8w1r3fWnI9tbf3bI81Z4kUpGcBcb2LQwxgA6rQyaaywy
         EDQZOJBJcBKsDP3+uO4LLxe+AJF9/wVa3YgYytzy/IOYHwXeAIrHkoOp+sizz3UyROHV
         84hjPfNn2mik6aS9KauqQptgafjsGlQVFQPL28vR+jYxSWLy0kkwodlH9evs0l69znCj
         ya1lmfDMy9OnxY0ecCnUtlUZaCfVcU0iKHC7XToeqpR32y1271NCKeA2+NVwK9r8Z9Va
         Jx8bR9zQ4AsSLF6bR4tzex2O8jvJjY+avCUTU6ELAV3OVxzap4FhFChnHUyeRy6fV+6w
         r9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RIHrM2T5t2yjqxj2JPTS71DBT+0RqAHHijTzNDzZvQ=;
        b=Z4meGqKylltw3rWMkhJwbqDdfJddxqJUS5puquka5QUNYnqXNMKl/YK8C7US1Li7vi
         k7pVGZRPnx7LHXrFze1LtfRqCYsPxGtUPAuJaXetf9GN3FPpilBExPiiIDA0iMz5BJ3p
         Yk1XUyqBbzPo2HRCBl2YgBrIxaxLLXl2a5AltOiKW46sFhwvxlCt+qzySg1GASb0xT67
         mr4xksWPct5R/34jdGPl+lpHud3dOS+oaDY61gjr1uaoI1heS+8ZQZpu3C8nMaoGeAVX
         llyZKgzqq7xajJTPAs2wwQZR27DmN/j63axRDsHwC5HU7VHSy10Q7b9ghp5LA7+oyIQV
         A1uQ==
X-Gm-Message-State: APjAAAWuzuP1VWurUc21OfRZME2HAC9MZILfzRcpu/FQEjS1aaaPEfkG
        G/D66eTZ1hsV6FbWrdfpP4Y=
X-Google-Smtp-Source: APXvYqyVtKZdQakEpy7jyH1XhEBn63IFkrC8JPdYR9oGo7S3PD9dTfWcVsiu9qgGrB00b2JedWkISg==
X-Received: by 2002:ac8:6146:: with SMTP id d6mr1980022qtm.271.1572391337209;
        Tue, 29 Oct 2019 16:22:17 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-136.wifi.ic.unicamp.br. [177.220.85.136])
        by smtp.gmail.com with ESMTPSA id a18sm633940qkc.2.2019.10.29.16.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:22:16 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 0/2] staging: sm750fb: Fixing codestyle error                   
Date:   Tue, 29 Oct 2019 20:22:05 -0300
Message-Id: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing typo and usage of spaces/tabs in file sm750_accel.c

Gabriela Bittencourt (2):
  staging: sm750fb: Fix typo in comment
  staging: sm750fb: Replace multiple spaces with tabs when it suits

 drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.20.1

