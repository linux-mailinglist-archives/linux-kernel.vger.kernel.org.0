Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0318A1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCRRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 13:41:36 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38381 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:41:36 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so1504676pje.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNn1MyCt2mGwclhH+lTXpL3RrIiuOj8izAxEFcctuh0=;
        b=DSNlMfPiqlXlQt/MsYetS2BQ6R2wEJ3c1t6KNws2trMZh9SxxamrZ1uHHuhiiO0o4/
         swt9vPbxpEdVlQxwaUbrf/rlg3t6ooSYAFJp9nxPCmrfk2rCak+nL8C9mUtrM9C3C6UJ
         D7ibkPeRWNoYuJ5uyJusWbQakk9zkngN1PipE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNn1MyCt2mGwclhH+lTXpL3RrIiuOj8izAxEFcctuh0=;
        b=YoEzStjiR1uvoM2T5QLqU+jFamdwt7NWaQ+jx69DOAdndWtlcJoi6AsETD39yVB+Hf
         fh1KfFD0yoA3L2DiLQabV86kF/dfPrO6XiaQ3rO+ehI7lqGNGPuteo/fetQzMhEz4QkT
         Y7Kcd0EUvKVjaSgOk2wbQytNnQPmQkZ70fQ1esq66fjbRm48WLa2c9wE4kn9kIEAsQvU
         fiYaxWTZSenMIBUs6A9FcGtUBVXKDE9lN5sP/vPx9FVSkAIP0Sp1d4qhiz1KnAoqDo9f
         20Ct5+oJng6EvUyAxVe9QnHnbWZIDlGYrsc1Ugzw1G2yRlhiunGqYNbrnD+Lz+zJGz51
         UjsA==
X-Gm-Message-State: ANhLgQ0bGLgo+RGitMfiX9SY1l2BKnGDBBkp4UeS/JLdu7dVqPnpszwd
        1w4J+sAmyEGFeZ76oTlpitJz4A==
X-Google-Smtp-Source: ADFU+vsCzkaDgLM3wrqCGqMUJ3MoMZKhTWiMKgz5c7yVRtAZN7plOO3+sCkPWlRVDngQgKPxV3NXQQ==
X-Received: by 2002:a17:90b:1918:: with SMTP id mp24mr4179183pjb.98.1584553294548;
        Wed, 18 Mar 2020 10:41:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k5sm2934127pju.29.2020.03.18.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:41:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] docs: locking: Fix a typo and drop :c:func:
Date:   Wed, 18 Mar 2020 10:41:31 -0700
Message-Id: <20200318174133.160206-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the hardirq section where we're missing a word and 
then drop :c:func: markup throughout.

Changes from v1:
 * New patch to drop :c:func:

Stephen Boyd (2):
  docs: locking: Add 'need' to hardirq section
  docs: locking: Drop :c:func: throughout

 Documentation/kernel-hacking/locking.rst | 176 +++++++++++------------
 1 file changed, 88 insertions(+), 88 deletions(-)


base-commit: fb33c6510d5595144d585aa194d377cf74d31911
-- 
Sent by a computer, using git, on the internet

