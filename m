Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0152F082D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 22:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfKEVWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 16:22:38 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36002 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbfKEVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:22:37 -0500
Received: by mail-wr1-f54.google.com with SMTP id w18so23228031wrt.3;
        Tue, 05 Nov 2019 13:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHqytR7QbfFBVoH9gVh1A5fo02Eb8gLrlSwRvWmM3gg=;
        b=blGBeBG94F++7ATYUm1857T7ZalY7Ok878RILXL3O0hEz9czh6llnWQHPYqi7byL22
         Gcv5JfteRhhn4WfGNJxq4liP1HAmIVxg5RI9SqKNx+iAVStRy4neQyGY12DJny9bUlBe
         uEMRNXoTe1kb8wyLoQnirPXCn2hiHD1lWwtngTpfOBite2ACVTmYakIRU3HXImYizl2b
         Ofen90OBD6OWj+tcy3Ty4hRPJPBqkhyEoHZZ06G5pomJUCpiOxPI2Q4t0KDTLtHQPXk4
         DXFxDh/zjnD/1KtRbOTAc4UUB0LoLRg608WEtYZnWM/oapXcuP6XDQiJBOH+rN1aAB1j
         M7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHqytR7QbfFBVoH9gVh1A5fo02Eb8gLrlSwRvWmM3gg=;
        b=RIybnRzRVBTadgFQ4YNQp9Mtoklh+5RndvanTkOEHpQkSKXoGqORpbmsPhSUs+5zqK
         kiVbwgAP/3ISCGYNkdNXYHI1Bh4TTs6sIUPXepARb8nSFby4VoNcNHAbdxQ5Fq/GDiUw
         DB6BteiLzkz8nxLBM0VqzV7XO2zc0FJrxEqzC99MP+st8fNoSl+qiHbJvoz/T8r4tnur
         QhBkm1u1eVTM/lKN7nDAO4t9l9tKCqkpiGv+ueTMvVUQfKi5QeWQR+CDRiM83K9nwhVx
         d/QFBgmNnhMqKFHA25OJmYKBI61w+s2WEpbGGR2zuCA3bifjrS/h9exyxdbWedW2NeyY
         ciFg==
X-Gm-Message-State: APjAAAWHvy7VheBayuD0215twfoPiCh1MRWjnxFDfdSW0oXQOcUSdCRs
        WjF6oGr2za0rrRMZRsqQXyI3DxHa
X-Google-Smtp-Source: APXvYqyo12pcTGO8/yIWimIqkpavFuBqSb5e316/shLbYA3p6NGHc1lHntzgNgwPOrNArn0fvrH2bw==
X-Received: by 2002:adf:f68f:: with SMTP id v15mr8572166wrp.171.1572988953727;
        Tue, 05 Nov 2019 13:22:33 -0800 (PST)
Received: from localhost.localdomain ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id 16sm1061197wmf.0.2019.11.05.13.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:22:33 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] cleanup of submission path
Date:   Wed,  6 Nov 2019 00:22:13 +0300
Message-Id: <cover.1572988512.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A minor cleanup of io_submit_sqes() and io_ring_submit().

v2: rebased
    move io_queue_link_head()

Pavel Begunkov (2):
  io_uring: Merge io_submit_sqes and io_ring_submit
  io_uring: io_queue_link*() right after submit

 fs/io_uring.c | 110 +++++++++++++-------------------------------------
 1 file changed, 28 insertions(+), 82 deletions(-)

-- 
2.23.0

