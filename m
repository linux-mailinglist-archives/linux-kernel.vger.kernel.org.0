Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CEA157269
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 11:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBJKEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 05:04:14 -0500
Received: from srv1.deutnet.info ([116.203.153.70]:47854 "EHLO
        srv1.deutnet.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgBJKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:04:14 -0500
X-Greylist: delayed 2187 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 05:04:13 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Message-Id:Date:Subject:Cc:To:From:in-reply-to;
         bh=Vjm+UzdU4EFGRYU3esvZaagkde+R1fpPiensw/dr2Go=; b=TpoMVyfbdIvJ71K1ZGmEePIjz
        cjvj611qh2sD3SbSrxINVDva2ZX6mSueuJnz0q6XAPvqFJpyxOyJyPCiCTkao5hFmC5aXP3leIsaO
        aUR3KrsjGglA9l2nQ7HPYvplymwx8hH59FzIoeHE+bZVVo5ObED3tgQBchGu9Lvk0vA3hHGNO0kUN
        DA2BVeUc67xvKoB5ieaF+Q0PbRWCGrg7qIiRFdazgg/yOtUXodnqAWvKZEGwMU0rFxFYmV4VZP+RD
        DExP4FIffBu0XFHYC0+fj7HGvJnHrOyw79xaksjDPvPqf5oQhrwEWkrdpx8eGKDCZNLF5wn58i+CG
        mrTdBCOFA==;
Received: from [2001:bc8:3dc9::1] (helo=srv100.deutnet.info)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j15Lw-0007fi-2U; Mon, 10 Feb 2020 10:27:40 +0100
Received: from agriveaux by srv100.deutnet.info with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j15Lv-00DSou-NC; Mon, 10 Feb 2020 10:27:39 +0100
From:   agriveaux@deutnet.info
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        agriveaux@deutnet.info
Subject: ARM: dts: sun5i: Add dts for inet86v_rev2
Date:   Mon, 10 Feb 2020 10:27:35 +0100
Message-Id: <20200210092736.3208998-1-agriveaux@deutnet.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM: dts: sun5i: Add dts for inet86v_rev2

Add Inet 86V Rev 2 support, based upon Inet 86VS.

Missing things:
- Accelerometer (MXC6225X)
- Touchpanel (Sitronix SL1536)
- Nand (29F32G08CBACA)
- Camera (HCWY0308)


