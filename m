Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA015211E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 20:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBDTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 14:31:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42403 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:31:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id e8so5072652plt.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 11:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFB/BdCgZTdBks/LEBdQ18bfbCn8FFgKC0d0O7TIgS0=;
        b=dBePQkx6I4a3sC1JoR6NTZij8u1i3OvnxQuG0NxiAJ/P3cM1uf0iGvbGEqOcB35yih
         d3Igrj/o0zOxILY3mcpD3xkrJhKwO9jW1i3gDFnfNUIG32CE49IB8GvhrBIy75ZEN5Nb
         RwSsd+BBOyyGGm+ut5EbIpvrix8tTkP8JXhr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFB/BdCgZTdBks/LEBdQ18bfbCn8FFgKC0d0O7TIgS0=;
        b=RmvqjeWGGhMxNK+U8wwbrzqsubQZiA82ABuKp+XxF3jZznrUU8gQWKhgn+Kx55N6LI
         qI7DIPQKluhBXQ315m4mAqncz/HlOF5wKXOl9bEq1LqQaNeFkkLr1KRixG1+AD+2qGuW
         bSYgjGDye8yDV9ua6lYpkM+O4bUT3/XhSI8AdtajKOPKbAgFJcy0ISFiym5VMgjKLUoK
         svonk5YBg7EN+32D7drmuMVQ5kPGN90q/gAQZ+rkBa1Q4Y73EOpxYJscg0M4v95pC7CN
         p8YBTG/E2o7MvIEw+JgGaexdZsTS9KpFq/1br2GPSHcjTkjAXb7kr90pBnjyx6GpsiqV
         QJ7Q==
X-Gm-Message-State: APjAAAXFK67vIpPUtG9tAslrzX9NkURSjIhgJX5fjJRQ0Qz4t01O5oU0
        5VuPcdgx2lQrJC7nAjWwY7iDqA==
X-Google-Smtp-Source: APXvYqzf9c2MZP/7ERU8b7VGvluFEwNq7jiuawqqDgFSu22JJUqhBVW+r7i9tKRsjfkMhVdWK31ZCQ==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr852714pjp.72.1580844713563;
        Tue, 04 Feb 2020 11:31:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g18sm24956626pfi.80.2020.02.04.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:31:53 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/3] Misc qcom geni i2c driver fixes
Date:   Tue,  4 Feb 2020 11:31:49 -0800
Message-Id: <20200204193152.124980-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small collection of qcom geni i2c driver fixes that
simplify the code and aid debugging.

Stephen Boyd (3):
  i2c: qcom-geni: Let firmware specify irq trigger flags
  i2c: qcom-geni: Grow a dev pointer to simplify code
  i2c: qcom-geni: Drop of_platform.h include

 drivers/i2c/busses/i2c-qcom-geni.c | 54 ++++++++++++++----------------
 1 file changed, 25 insertions(+), 29 deletions(-)

-- 
Sent by a computer, using git, on the internet

