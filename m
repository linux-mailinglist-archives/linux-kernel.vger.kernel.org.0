Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8CE12BED8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 21:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfL1U2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 15:28:33 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:37888 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1U2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:28:33 -0500
Received: by mail-pj1-f54.google.com with SMTP id l35so6450810pje.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:subject:date:message-id;
        bh=ELa/jGPIOrAAV05/eqnGYJJOo9NMRWnP5mBoX9xIpX4=;
        b=IPJ5n0EM9h2gn0hTw85cEkijLamqQMZANvY0f11Rb7GCcBLkXhPvItESGi6Jy+B04O
         3K75xW+FZ0x7EBLaJ92m5bJZMNHgNplsuR4pWWf3xVX9/QvjX9UaoiMRrdSTRvcRhyig
         AUU6mJX88Hc85LVyUBWs70WFRAvacjIBowUfZmAoo9Rlk10PTnhpyLKj+OYVVBO7XVWM
         VioW+rvsYOYS5VeVAaO7N9yZu6kCoBIHbdQrvbXKfivPmaEWZWag+labu984popL5XVd
         JzGy5S+bWdMzaImyab94AVZ+efefOvESdQfXAFeYIkKT6E/9Wt2QAKJMHyQzGjWdMEdB
         rYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ELa/jGPIOrAAV05/eqnGYJJOo9NMRWnP5mBoX9xIpX4=;
        b=UfwMXEiqsBRhMcNnZ9RZ3/pF0lGvBvpx/ZRK7NDHzGPYIMZHtf4A3FadVoy07iP4yl
         ZKgoj0hR3kKIOq+Xhi7ewlWWmOn/2ixcG5Ade7hlBMZT3zphPeD3XA/z0wA0yulbgDum
         b1fu5idn4te9CDPBYnsuT/PD6aHdr6nk9OJMmxRxChGchL8fH1i5m/ec7OPCVQZ76D1g
         rc4tFQ1oB+Cz1+UyFksmPvllUlUBMpFjA8A1HZRhALlZ4iqjfYo6MBoB+fPceMyNXNKw
         jsj9UytU8XXBBSZtHSUmUjiGRsDCiplZnCiJ019dmYE/zK/9aoiS3rqxHn4pTi++8TC5
         sgJw==
X-Gm-Message-State: APjAAAWppHusi0+gGiQCzKnsr/TCJyxYAvGpumDTAJejGyvEIgYtPwA1
        W9OYrDMxqGyCiExjbLFIFobeoA==
X-Google-Smtp-Source: APXvYqzSW3zJ2qHck05XqAFkd1G9bQ0VrMEW3x5Q8jS46ws/4QQAvZnYXyr1CSz076R1vh0G01ToDg==
X-Received: by 2002:a17:90a:f998:: with SMTP id cq24mr33688998pjb.6.1577564912415;
        Sat, 28 Dec 2019 12:28:32 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id i68sm46771169pfe.173.2019.12.28.12.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:28:31 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Subject: 
Date:   Sat, 28 Dec 2019 22:28:14 +0200
Message-Id: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is series of various sun8i fixes.

Currently I am working on bringing-up Android on sunxi platform.
And during UI debugging process a lot of issues was observed.

This patch-set is far from perfect, but we could start from it and polish
during review process.

