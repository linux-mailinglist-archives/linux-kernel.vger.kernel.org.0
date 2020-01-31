Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83ABF14F36A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 21:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgAaUxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 15:53:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33198 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgAaUw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:52:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so10303823wrq.0;
        Fri, 31 Jan 2020 12:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWqN53qGD7YWdEc3HI5rGCWSdWNRldW163e5Yux+Ftg=;
        b=IyN8HXJvLQYrqaO+Y/Vtcv0vKP1hrKysiclAEe/K0zR+jdERLKvl0kbUzvPBOfo1qK
         97JeU90R3iV0NL9kRb7u5w5H87facu5RCicbyVYb3xwDxg7mT8YaqY84hHzM1nOkriIs
         qYwvKocQaDrInmRQ7rQUTZdrhMnsF7iz9GsCvIK5h8zEvRXX9qaPDe/1QiePq/xFkFTu
         NMC4jR83jL5dYqYUvZBR+7AQW1cB62krT923P+1Xa3Etdgpzgi3W6E5EsoOh9x5OKDd8
         ggqaXBjGwIhw18dfX4vE5fzoO001Tu9435AU1Qtdk6ZI1NXmrXy/TQ/p1mCc6FfeWc+u
         5ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWqN53qGD7YWdEc3HI5rGCWSdWNRldW163e5Yux+Ftg=;
        b=KolEV4njOuZF0RIgEdq4ABCm2vOL1hj0aXf6SUt+iFpVTb4BZRbQp8NSYb+9J9iPxR
         kkg871gCncwYYWwuT/rKens0fB74rBPD9+b2ufNUxCdLfCMHv9amtG4aXK9Oo9QNRNTx
         7UJKvtn8kE17cvz6nJKOhmdvXYT3mjUj9XkN1GNpluNoeDgAly6gcEbZOwBG9aFhLALL
         xqTTPzRTs7pGmfX/aGJaVgTiQFwOcVMHNZt+/UGUP/qmlCSUB0+gGpmPcyOd1jnFsqV3
         OrrDikZjUkrEyuu0OLJOygiCkka7Fv8Zw9JMP3m/Wqtkc1ivf0OaLDb5Yoh/YAjw6GrQ
         YvDA==
X-Gm-Message-State: APjAAAX9CMPA4OuFcnWQj1icazNCJhQhg/NWT4SRD405SJreHB7PQpQA
        088bfrhKuepSMsAycxxjL/s=
X-Google-Smtp-Source: APXvYqzBv0WARDdTJbiXddLyM58JY3KEWlWmAHqur8BcvXLRs98GL79Tf0q3pn41m4eJQbt8YsXxmQ==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr301384wrx.66.1580503975129;
        Fri, 31 Jan 2020 12:52:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:bcd7:b36c:40fc:d163])
        by smtp.gmail.com with ESMTPSA id z3sm13483738wrs.94.2020.01.31.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:52:54 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, paulmck@kernel.org
Cc:     SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Documentation/ko_KR/howto: Update broken web addresses
Date:   Fri, 31 Jan 2020 21:52:35 +0100
Message-Id: <20200131205237.29535-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131205237.29535-1-sj38.park@gmail.com>
References: <20200131205237.29535-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 0ea6e6112219 ("Documentation: update broken web addresses.")
removed a link to 'http://patchwork.ozlabs.org' in howto, but the change
has not applied to the Korean translation.  This commit simply applies
the change to the Korean translation.  The link is restored now, though.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/howto.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 6419d8477689..627ce97810d1 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -318,8 +318,8 @@ Andrew Morton의 글이 있다.
 리뷰 프로세스는 patchwork라는 도구를 통해 추적된다. patchwork은 등록된 패치와
 패치에 대한 코멘트, 패치의 버전을 볼 수 있는 웹 인터페이스를 제공하고,
 메인테이너는 패치를 리뷰 중, 리뷰 통과, 또는 반려됨으로 표시할 수 있다.
-대부분의 이러한 patchwork 사이트는 https://patchwork.kernel.org/ 또는
-http://patchwork.ozlabs.org/ 에 나열되어 있다.
+대부분의 이러한 patchwork 사이트는 https://patchwork.kernel.org/ 에 나열되어
+있다.
 
 통합 테스트를 위한 linux-next 커널 트리
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.17.1

