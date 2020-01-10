Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68D11374B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgAJRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgAJRXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:23:49 -0500
Received: from localhost.localdomain (unknown [83.218.167.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB891206ED;
        Fri, 10 Jan 2020 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578677028;
        bh=bJ7uSsD1XdjwYUW0kN2RzidhFDTOge2H7C13hNoWdlU=;
        h=From:To:Cc:Subject:Date:From;
        b=BU4Wcwnx0nkMXq9Pk3Zt3O8kDaE3+GH9VbRThsJaOH8a7utkjXCts3XO4Ffg1YAME
         Gwk9WLVa/1c25PI4L1JY+RtS2khz7tNP9CR2DV4m+DQbmN+3hoXbUBNZSR7lvkjdu/
         AGCTRS6MA3WSI1rrqIJOki89lgGhyh+Rn2FiOHsM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/3] ARM: Pull for v5.6
Date:   Fri, 10 Jan 2020 18:23:29 +0100
Message-Id: <20200110172334.4767-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Except three pull requests, also separate two patches
at the end - not worth its own pull.

Best regards,
Krzysztof
