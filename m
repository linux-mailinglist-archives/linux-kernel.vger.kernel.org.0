Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD49179A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfHRQAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 12:00:06 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:19017 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHRQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:00:06 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d11 with ME
        id qfzz2000v0Dzhgk03g00Jq; Sun, 18 Aug 2019 18:00:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Aug 2019 18:00:04 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        xiaojie.yuan@amd.com, Hawking.Zhang@amd.com, Jack.Xiao@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amdgpu: Fix a typo in the include header guard of 'navi12_ip_offset.h'
Date:   Sun, 18 Aug 2019 17:59:57 +0200
Message-Id: <20190818155957.4029-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'_navi10_ip_offset_HEADER' is already used in 'navi10_ip_offset.h', so use
'_navi12_ip_offset_HEADER' instead here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/include/navi12_ip_offset.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
index 229e8fddfcc1..6c2cc6296c06 100644
--- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
@@ -18,8 +18,8 @@
  * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
-#ifndef _navi10_ip_offset_HEADER
-#define _navi10_ip_offset_HEADER
+#ifndef _navi12_ip_offset_HEADER
+#define _navi12_ip_offset_HEADER
 
 #define MAX_INSTANCE                                       7
 #define MAX_SEGMENT                                        5
-- 
2.20.1

