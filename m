Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D476F5C5B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 01:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfKIAki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 19:40:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45569 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfKIAki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:40:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so6107296pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 16:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AByCPRt6TSYvOMrWfQaIDomi50/YNtjLj0E5fCsw8+A=;
        b=ODLoSslVNz7PzgNe+vCXbT+Na90Rj+ERnsCGgx6FkLrYKub0DJ6dtqd2ZKjTXL5tJD
         xJa649+asakizL+nayl/n7zgsSWcFhWHQXzIbmSMveihjmE3djbqf9aLfLyotClUxYPL
         uTVQiJzo+hYiIjdJVSPzcEe1PWF1WGCHu/Snm7mTqXs4x51mwjzvPMMX/v9umjI3Nkq/
         GnisVx1JqPnnxkQSlmgw9BFRoaxbD8ayDpbpWSZT/MXdo2ipnlTZh0Me0XnVDM+y1Ik/
         amykAPZ4rxY27upimzRxfHH8Frtlwn7/sOQfAqnnb1r5Hyjev7XI64FzNo5cR/jSjbvM
         yZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AByCPRt6TSYvOMrWfQaIDomi50/YNtjLj0E5fCsw8+A=;
        b=noyTfUlBGYoQS6n+MLs79BB4uVtTW0ECIEY/likr/TTTAgF3++RrrkWc/ho9HXLYxA
         +liHW7Q1DuWu8boc8UeQEjtgkgeiZJ+mnNc1e4hDrDmotd1MzqWRwio+iu+tgP7KlVoJ
         fZ+a3DL7ahMlgliji0n/gc6Q8BUhFTujvkTvP9Bv8+fFrVg4jSjoU6JOJW1u1i/8mWWM
         9k8mL+1p1+J2GEQ1HzZoqxkjhZpYFoPfuIIZp2borpYMA7GAi7jV6GvacUB0j9hS63qu
         KD2dvTh9PCxwGfa8+3SPfTDZ+6zrvO2am3zrcCZzeiaD1VDWnc+E2mHe5kjEdZCzdHwQ
         VpnA==
X-Gm-Message-State: APjAAAXqIfg/0a9e0hsvLsmnkm+sTKp6sGBgGjcfJPRLb/lNvUMFZilI
        A19Uy+CrxQyuHj6kS5ZmsCepwQ==
X-Google-Smtp-Source: APXvYqzmQV2pqI612zNat/Qv4aguEWdnkc1e0UX7Tys8Ps5fLxso+IkSWQ9uzJM2E/5/unepZEl0dQ==
X-Received: by 2002:a17:90b:948:: with SMTP id dw8mr17702226pjb.21.1573260037495;
        Fri, 08 Nov 2019 16:40:37 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y36sm6681461pgk.66.2019.11.08.16.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:40:36 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v2 0/2] remoteproc: mss: Improve mem_assign and firmware load
Date:   Fri,  8 Nov 2019 16:40:31 -0800
Message-Id: <20191109004033.1496871-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two things came up in the effort of figuring out why the modem crashed the
entire system when being restarted; the first one solves the actual problem, in
that it's not possible to reclaim the main modem firmware region unless the
modem subsystem is running - causing the crash.

The second patch aligns the firmware loading process to that of the downstream
driver, which seems to be a requirement in 8974 as well.

Bjorn Andersson (2):
  remoteproc: qcom_q6v5_mss: Don't reassign mpss region on shutdown
  remoteproc: qcom_q6v5_mss: Validate each segment during loading

 drivers/remoteproc/qcom_q6v5_mss.c | 92 +++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 33 deletions(-)

-- 
2.23.0

