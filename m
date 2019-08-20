Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E6C9524C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 02:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfHTASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 20:18:12 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:34784 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfHTASL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:11 -0400
Received: by mail-vk1-f201.google.com with SMTP id l25so939005vkn.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VwF/91o4aMHrQL5QM73+22fSApAs/2NiXgYkaBxXzFM=;
        b=CUH1JVMihclalX5q2seurV8HS9Qtk8nNORqI67CyNzpt8f4YKj9PsBh2yhEiLjpN0N
         Fknxxgr4PJdGVml+Jh2OhZg5E3JvdD0eGWvF5Fmj48bmwNl5sWVh0boqVtCTRu0mQHas
         1xR/eyrBcny62z5z0RXhFDmY63lItRvyMCbNrGAku/YYgZEVoLwuK/uqG8c8z1Py5OSr
         A6r1/J/F5nwciw7FJDr6x0eGnjeLDqYrBnU6tU/LRSjombP6Ii7IjYs4x7MFqzCatoKk
         c5ORjqJyd7wx6vbPsu0EDtwg03Dm+tZqvDQMHo7P8iZ7nhjRLYSJI6ZiO9T9s7fsnTfy
         eFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VwF/91o4aMHrQL5QM73+22fSApAs/2NiXgYkaBxXzFM=;
        b=pzHKdpkOl198/SYCGzlaDZdUd8wgngflLJ37sXOF5HR6e0lZg6Y0c6bSbvw0pTjq1D
         IFmi64gscR/FLsika4TDt43lg9FXthrfLxu4dhwYl1sqWp+T4TTSBw17PY503cv47Cxt
         +cpdh+Yzt6pBarl79O0WZ83SIMCMN86S4bV4uGaExDEy5gDJV2GlAW2wURcs5JVKGUVG
         eMg7RGqVv+SdouZhpYjEnp475bEGbpSOQhFi1owBqtzeXoR3BD+uhlrQsPydWndh2S4+
         qbjuwdx10quiGxFnxIo6sl1xTzPmZSL02oYBqavD+fc1NisjqSdF8ztXMidX7jpStnp5
         Oeog==
X-Gm-Message-State: APjAAAW+IunpeITTpNDmgCeHoxrUsKLZoMJ5kKGv2/JjuhgcsMZhXuID
        4K1T/hI65M/6pYrKsnF9OOMAmpUSr2+7XvM+vdeZig==
X-Google-Smtp-Source: APXvYqz41WMqs6ZJ50zP00x9Ki+LU6ocf63OApf5Deq/yukX6RTwToHjUAj4ZEXRYb662kA7qgoSvA9acMVNeIZGiXQafw==
X-Received: by 2002:ac5:c801:: with SMTP id y1mr9262710vkl.41.1566260290111;
 Mon, 19 Aug 2019 17:18:10 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:36 -0700
Message-Id: <20190820001805.241928-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 00/29] Add kernel lockdown functionality
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After chatting with James in person, I'm resending the full set with the
fixes merged in in order to avoid any bisect issues. There should be no
functional changes other than avoiding build failures with some configs,
and fixing the oops in tracefs.


