package khoaluantotnghiep.controller.AI;//package khoaluantotnghiep.controller.AI;
//
//import khoaluantotnghiep.api.AI.OpenAIService;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;
//
//@Controller
//public class AIController {
//
//    private OpenAIService openAIService = new OpenAIService();
//
//    @RequestMapping(value = "/admin-ai", method = RequestMethod.GET)
//    public ModelAndView showAIPage() {
//        ModelAndView mav = new ModelAndView("admin/AI/index"); // Trang JSP: /WEB-INF/views/admin/ai/index.jsp
//        return mav;
//    }
//
//    @RequestMapping(value = "/admin-ai/suggest", method = RequestMethod.POST)
//    @ResponseBody
//    public String suggestFromAI(@RequestParam("prompt") String prompt) {
//        return openAIService.askAI(prompt);
//    }
//}
