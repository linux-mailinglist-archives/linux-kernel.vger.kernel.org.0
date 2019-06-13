Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEE441D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391751AbfFMQQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:16:51 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40580 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391631AbfFMQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:16:48 -0400
Received: by mail-oi1-f175.google.com with SMTP id w196so14871640oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=e9zx/pEiXDJzZ9toLW3J00vN7pUv4giE6QKYgK4Z8cLF7KDo7BU1BLZHg29Kie0est
         pOiMVO8Ehj3N6wEiKOy/dahQ7wxBnu5zYvHq4zUEN+7I92pVv2HZyc/gNzWyVIBpxc4o
         OUBWQ/Kt2lRcv8XqUGCboaejw3OFwt13RfoNykvmzuXoSiGWeYWYyRuLnwvb7xyzae+T
         DO1d6yCijhOd6xfOVjxs15/4FgQax9wKNEYS2Jab0qGqK+MM9S7NvuloPs2TRufHeycX
         433HEQaljbH6mT2kNVPtuH8Y10RhUn+DJyXbbSEOVUjFklWQgf7LaZqaBtP2t0sEplXv
         iQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=lx0+PardRY5qzh3yK9rKdj3NQTuvBP/ykE9TfX9oKSWqQCnl8nKEa7aauLGaO4VRzu
         0gl4mG0qRXCBU1w7G5A7XkXP46bzMRXJKUl0bS5psfnBGboZ970nS8pbZIRD+bxvLbWf
         +kT7g/gvk+qvDD5FKuLz7XVNP7VKlMjWdAIORCoy/sP1stnHV3QDJ77UsJ/Ok0l3y3f7
         FIho807v+H1CPy2B9ES75vsiQcNRe8MzoBQ4u7dze6SbvUlE2otMZRb/7WalO6RxLSaR
         TvKp+m5brpDZxNARSPNM9icdY+8YAXYX47pHnj1sWIGvQQgIgvzKQNSjlRME7zSGtNvF
         rsuQ==
X-Gm-Message-State: APjAAAWl4hWvclzscu8yIcolhSr8S/wMwXqb2GN1333zFevWzVmbCVAl
        8HnhTKD2Qm4KGOrjH+OTdwPUN/D03+C9yHEpZlgrVTar
X-Google-Smtp-Source: APXvYqwD59MXs1TcNhGPvogRwNRkmvLa7ZnjMNCm7xR3nOfSJ/qw4ewlrDXwny5DmyuB9t/gle9O2FmSPAOVKsr8k3E=
X-Received: by 2002:aca:af06:: with SMTP id y6mr3600908oie.137.1560442607945;
 Thu, 13 Jun 2019 09:16:47 -0700 (PDT)
MIME-Version: 1.0
From:   "R.F. Burns" <burnsrf@gmail.com>
Date:   Thu, 13 Jun 2019 12:16:37 -0400
Message-ID: <CABG1boNKq4Q49t2tFA863hi=jrFnJLarER5nyyGSpFPMbT1Qvg@mail.gmail.com>
Subject: PC speaker
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to write a kernel module which, when loaded, will blow
the PC speaker?
